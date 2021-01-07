import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Post {
  String id;
  String id_usuario;
  String texto;
  String imgPath;
  String dataPostagem;
  int status = 1;
  bool ativo = true;

  Post({this.id_usuario, this.texto, this.imgPath, this.dataPostagem});

  Map<String, dynamic> toMap() {
    return {
      'id_usuario': this.id_usuario,
      'texto': this.texto,
      'imagem': this.imgPath,
      'data_postagem': this.dataPostagem,
      'ativo': this.ativo,
      'status': this.status
    };
  }
}

class Postagens with ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> criarPostagem(Post post) async {
    try {
      await firestore
          .collection('postagens')
          .add(post.toMap())
          .then((document) => post.id = document.id);
    } catch (e) {
      return 'ERRO!';
    }
  }

  Future<void> editarPostagem(
      {String texto,
      String id_postagem,
      String id_autor,
      String imagem}) async {
    try {
      await firestore
          .collection('postagens')
          .doc(id_postagem)
          .update({'texto': texto, 'imagem': imagem});
    } catch (e) {
      print(e);
    }
  }
}
