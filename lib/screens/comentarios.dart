import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.Dart';

import 'package:ifs_network/managers/comentarios_provider.dart';
import 'package:ifs_network/managers/usuario_gerenciador.dart';
import 'package:ifs_network/widgets/comentario/comentario.dart';

class ComentariosScreen extends StatelessWidget {
  String docPostagem;
  ComentariosScreen({this.docPostagem});
  GlobalKey<FormState> formkey = GlobalKey();

  TextEditingController textoController = TextEditingController();

  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    UsuarioGerenciador usuarioGerenciador = Provider.of(context);
    return Scaffold(
      key: scaffoldkey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Comentários",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconTheme.of(context).copyWith(color: Colors.white),
      ),
      body: new GestureDetector(
        onTap: () {
          SystemChannels.textInput.invokeMethod('TextInput.hide');
        },
        child: new Container(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('postagens')
                  .doc(docPostagem)
                  .collection('comentarios')
                  .orderBy('data', descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.teal),
                    ),
                  );
                }

                return Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      height: 0,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 1,
                      child: ListView(
                        children: snapshot.data.docs.map((document) {
                          return Container(
                            child: FutureBuilder<Usuario>(
                                future: usuarioGerenciador
                                    .pegarUsuarioPorId(document['id_autor']),
                                builder: (ctx, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                      child: Container(),
                                    );
                                  } else {
                                    return ComentarioTile(
                                      docComentario: document,
                                      usuario: snapshot.data,
                                      docPostagem: docPostagem,
                                    );
                                  }
                                }),
                          );
                        }).toList(),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: Form(
                        key: formkey,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: TextFormField(
                                  maxLength: 500,
                                  expands: true,
                                  maxLines: null,
                                  minLines: null,
                                  keyboardType: TextInputType.multiline,
                                  maxLengthEnforced: true,
                                  cursorColor: Colors.teal,
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
                               SystemChannels.textInput.invokeMethod('TextInput.hide');
                                try {
                                  if (formkey.currentState.validate()) {
                                    context
                                        .read<Comentarios>()
                                        .comentar(Comentario(
                                          texto: textoController.text,
                                          data:
                                              DateTime.now().toIso8601String(),
                                          id_postagem: docPostagem,
                                          id_autor: usuarioGerenciador
                                              .auth.currentUser.uid,
                                        ));
                                  }
                                  scaffoldkey.currentState
                                      .showSnackBar(SnackBar(
                                    content: const Text('Comentario feito!'),
                                    backgroundColor: Colors.green,
                                    duration: Duration(milliseconds: 600),
                                  ));
                                  textoController.text = "";
                                  print("SUCESSSOOO");
                                } catch (e) {
                                  print("ERROOOOOOOO: $e");
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              }),
        ),
      ),
    );
  }
}
