import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:ifs_network/managers/comentarios_provider.dart';
import 'package:ifs_network/managers/posts_provider.dart';
import 'package:ifs_network/screens/comentarios.dart';
import 'package:ifs_network/screens/perfil.dart';
import 'package:ifs_network/widgets/feed/post_edicao.dart';
import '../../managers/usuario_gerenciador.dart';

class Posts extends StatefulWidget {
  GlobalKey<ScaffoldState> scaffoldkey;
  final Map<String, dynamic> postMap;
  Usuario usuario;
  String id_usuario;
  var docPostagem;

  Posts({this.usuario, this.postMap, this.docPostagem, this.scaffoldkey});

  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  bool _expanded = false;
  CollectionReference postagens =
      FirebaseFirestore.instance.collection('postagens');

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController textoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Postagens postagem = Provider.of(context);
    UsuarioGerenciador usuarioGerenciador = Provider.of(context);
    String dataString = widget.postMap['data_postagem'] as String;
    DateTime data = DateTime.parse(dataString);

    showAlertDialog(BuildContext context) {
      Widget cancelButton = FlatButton(
        child: Text(
          "Cancelar",
          style: TextStyle(color: Colors.grey),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      Widget continueButton = FlatButton(
        color: Colors.red,
        child: Text("Excluir"),
        onPressed: () {
          postagens.doc(widget.docPostagem).delete();
          Navigator.of(context).pop();
        },
      );

      AlertDialog alert = AlertDialog(
        actionsPadding: EdgeInsets.fromLTRB(10, 10, 30, 10),
        title: Text("Tem certeza que deseja excluir essa publicação?"),
        actions: [
          cancelButton,
          continueButton,
        ],
      );

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    String dataPostagem = DateFormat('dd-MM-yyyy – kk:mm').format(data);

    return Card(
      color: Colors.white,
      margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
      shadowColor: Colors.grey[50],
      child: Column(
        children: [
          Container(
            child: Column(
              children: [
                Container(
                  height: 60,
                  color: Colors.grey[100],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(
                              Perfil(
                                  usuario: widget.usuario,
                                  id_usuario: widget.postMap['id_usuario']),
                              transition: Transition.zoom,
                              duration: Duration(milliseconds: 500));
                        },
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(widget.usuario.imagem),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Text(widget.usuario.nome),
                            )
                          ],
                        ),
                      ),
                      Text(
                        dataPostagem,
                        style: TextStyle(color: Colors.grey, fontSize: 10),
                      ),
                      DropdownButton<String>(
                        icon: Icon(Icons.more_vert),
                        iconSize: 24,
                        elevation: 2,
                        style: TextStyle(color: Colors.teal),
                        underline: Container(
                          height: 0,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            if (newValue.compareTo('Excluir') == 0) {
                              showAlertDialog(context);
                            } else {
                              print("erro!");
                            }
                            if (newValue.compareTo('Editar') == 0) {
                              Get.to(PostEdicao(
                                docPostagem: widget.docPostagem,
                                postMap: widget.postMap,
                                scaffoldkey: widget.scaffoldkey,
                                usuario: widget.usuario,
                              ));
                            }

                            if (newValue.compareTo('Denunciar') == 0) {
                              //TODO: denunciar publicacao
                            }
                          });
                        },
                        items: widget.usuario.id ==
                                usuarioGerenciador.auth.currentUser.uid
                            ? <String>['Editar', 'Excluir', 'Denunciar']
                                .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList()
                            : <String>['Denunciar']
                                .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Column(children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        widget.postMap['texto'],
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      width: double.infinity,
                      child: Image.network(widget.postMap['imagem']),
                    )
                  ]),
                ),
                Divider(),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Align(
                    alignment: AlignmentDirectional.topCenter,
                    child: GestureDetector(
                      child: Text(
                        'ver comentários',
                        style: TextStyle(color: Colors.teal, fontSize: 12),
                      ),
                      onTap: () {
                        Get.to(
                            ComentariosScreen(docPostagem: widget.docPostagem),
                            transition: Transition.zoom,
                            duration: Duration(milliseconds: 500));
                      },
                    ),
                  ),
                ),
                Divider(),
                Form(
                  key: formkey,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: _expanded ? 100 : 40,
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: TextFormField(
                            maxLength: 500,
                            expands: true,
                            maxLines: null,
                            minLines: null,
                            keyboardType: TextInputType.multiline,
                            maxLengthEnforced: true,
                            cursorColor: Colors.teal,
                            onTap: () {
                              setState(() {
                                _expanded = true;
                              });
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Adicione um comentário',
                              counterText: '',
                              hintStyle: TextStyle(
                                  color: Colors.grey[400], fontSize: 14),
                            ),
                            controller: textoController,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.send,
                          color: Colors.teal,
                        ),
                        onPressed: () {
                          try {
                            if (formkey.currentState.validate()) {
                              context.read<Comentarios>().comentar(Comentario(
                                    texto: textoController.text,
                                    data: DateTime.now().toIso8601String(),
                                    id_postagem: widget.docPostagem,
                                    id_autor:
                                        usuarioGerenciador.auth.currentUser.uid,
                                  ));

                              textoController.text = "";
                            }
                            widget.scaffoldkey.currentState
                                .showSnackBar(SnackBar(
                              content: const Text('Comentario feito!'),
                              backgroundColor: Colors.green,
                              duration: Duration(milliseconds: 600),
                            ));
                            print("SUCESSSOOO");
                          } catch (e) {
                            print("ERROOOOOOOO: $e");
                          }

                          setState(() {
                            _expanded = !_expanded;
                          });
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
