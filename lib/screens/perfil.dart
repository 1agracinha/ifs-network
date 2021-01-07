import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ifs_network/managers/usuario_gerenciador.dart';
import 'package:ifs_network/widgets/feed/posts.dart';
import 'package:ifs_network/widgets/perfil/conteudo_perfil.dart';

class Perfil extends StatelessWidget {
  Usuario usuario;
  String id_usuario;

  Perfil({this.usuario, this.id_usuario});
  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    UsuarioGerenciador usuarioGerenciador = Provider.of(context);

    return Scaffold(
      key: scaffoldkey,
      body: Column(
        children: [
          ConteudoPerfil(
            usuario: usuario,
            id_usuario: id_usuario,
            scaffoldkey: scaffoldkey,
          ),
          Expanded(
            child: Container(
              color: Colors.grey[50],
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('postagens')
                    .where('id_usuario', isEqualTo: "${usuario.id}")
                    .orderBy('data_postagem', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                        child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.teal),
                    ));
                  else if (snapshot.data.docs.length == 0)
                    return Center(child: Text('Não há postagens'));
                  else
                    return Container(
                      padding: EdgeInsets.all(4),
                      child: ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (ctx, i) {
                          var idUser = usuario.id;
                          var postagem = snapshot.data.docs[i].data();
                          var doc = snapshot.data.docs[i].id;
                          return FutureBuilder(
                              future:
                                  usuarioGerenciador.pegarUsuarioPorId(idUser),
                              builder: (ctx, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: Container(),
                                  );
                                } else {
                                  return Posts(
                                      docPostagem: doc,
                                      postMap: postagem,
                                      usuario: snapshot.data);
                                }
                              });
                        },
                      ),
                    );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
