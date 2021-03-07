import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ifs_network/managers/comentarios_provider.dart';
import 'package:ifs_network/managers/usuario_gerenciador.dart';

class ComentarioTile extends StatefulWidget {
  QueryDocumentSnapshot docComentario;
  Usuario usuario;
  var docPostagem;
  ComentarioTile({this.docComentario, this.usuario, this.docPostagem});

  bool editando = false;

  TextEditingController controller = TextEditingController();

  @override
  _ComentarioTileState createState() => _ComentarioTileState();
}

class _ComentarioTileState extends State<ComentarioTile> {
  @override
  Widget build(BuildContext context) {
    Comentarios comentarios = Provider.of(context);
    UsuarioGerenciador usuarioGerenciador = Provider.of(context);
    String imagem;
    showAlertDialog(BuildContext context) {
      // Comentarios comentario = Provider.of(context);

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
          FirebaseFirestore.instance
              .collection('postagens')
              .doc(widget.docPostagem)
              .collection('comentarios')
              .doc(widget.docComentario.id)
              .delete();
          Navigator.of(context).pop();
        },
      );

      AlertDialog alert = AlertDialog(
        actionsPadding: EdgeInsets.fromLTRB(10, 10, 30, 10),
        title: Text("Tem certeza que deseja excluir esse comentário?"),
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

    if (widget.usuario.imagem != null) {
      imagem = widget.usuario.imagem;
    } else {
      imagem =
          "https://conceitos.com/wp-content/uploads/psicologia/Perfil-Psicologico.jpg";
    }
    return ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(imagem)),
        title: Text(widget.usuario.nome),
        subtitle: widget.editando
            ? Container(
                height: 200,
                child: TextField(
                  controller: widget.controller,
                  expands: true,
                  minLines: null,
                  maxLines: null,
                ),
              )
            : Text(widget.docComentario['texto']),
        trailing: widget.editando
            ? IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  comentarios.editarComentario(
                      texto: widget.controller.text.trim(),
                      id_comentario: widget.docComentario.id,
                      id_postagem: widget.docPostagem);
                })
            : DropdownButton<String>(
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
                      print("ERRO!");
                    }
                    if (newValue.compareTo('Editar') == 0) {
                      widget.editando = true;
                      widget.controller.text = widget.docComentario['texto'];
                    }

                    if (newValue.compareTo('Denunciar') == 0) {
                      //TODO: denunciar comentario
                    }
                  });
                },
                items: widget.docComentario['id_autor'] ==
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
              ));
  }
}
