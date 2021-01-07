import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ifs_network/screens/tirar_glow.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.Dart';

import 'package:ifs_network/managers/usuario_gerenciador.dart';
import 'package:ifs_network/widgets/feed/menu_bar.dart';
import 'package:ifs_network/widgets/feed/posts.dart';

class Feed extends StatelessWidget {
  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    

    UsuarioGerenciador usuarioGerenciador = Provider.of(context);
    return Scaffold(
      key: scaffoldkey,
      body: GestureDetector(
        onTap: () {
          SystemChannels.textInput.invokeMethod('TextInput.hide');
        },
        child: Column(
          children: [
            MenuBar(),
            Expanded(
              child: Container(
                color: Colors.grey[50],
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('postagens')
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
                        child: ScrollConfiguration(
                          behavior: NoGlowBehavior(),
                          child: ListView.builder(
                           
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (ctx, i) {
                              var idUser =
                                  snapshot.data.docs[i].data()['id_usuario'];
                              var postagem = snapshot.data.docs[i].data();
                              var doc = snapshot.data.docs[i].id;
                              return FutureBuilder(
                                  future: usuarioGerenciador
                                      .pegarUsuarioPorId(idUser),
                                  builder: (ctx, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                        child: Container(),
                                      );
                                    } else {
                                      return Posts(
                                          scaffoldkey: scaffoldkey,
                                          docPostagem: doc,
                                          postMap: postagem,
                                          usuario: snapshot.data);
                                    }
                                  });
                            },
                          ),
                        ),
                      );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
