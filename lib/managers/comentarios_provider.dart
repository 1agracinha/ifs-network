import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Comentario {
  String texto;
  String id;
  String id_autor;
  String id_postagem;
  String data;
  int status = 1;
  bool ativo = true;

  Comentario({this.texto, this.id_autor, this.data, this.id_postagem});

  Map<String, dynamic> toMap() {
    return {
      'id_autor': this.id_autor,
      'texto': this.texto,
      'data': this.data,
      'ativo': this.ativo,
      'status': this.status
    };
  }
}

class Comentarios with ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> comentar(Comentario comentario) async {
    try {
      await firestore
          .collection('postagens')
          .doc(comentario.id_postagem)
          .collection('comentarios')
          .add(comentario.toMap())
          .then((document) => comentario.id = document.id);
    } catch (e) {
      return 'ERRO!';
    }
  }

  Future<void> editarComentario(
      {String texto, String id_comentario, String id_postagem}) async {
    try {
      await firestore
          .collection('postagens')
          .doc(id_postagem)
          .collection('comentarios')
          .doc(id_comentario)
          .update({'texto': texto});
    } catch (e) {
      print(e);
    }
  }
}
