import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:ifs_network/managers/usuario_gerenciador.dart';
import 'package:ifs_network/screens/perfil_edicao.dart';

class ConteudoPerfil extends StatelessWidget {
  Usuario usuario;
  String id_usuario;
  GlobalKey<ScaffoldState> scaffoldkey;

  ConteudoPerfil({this.usuario, this.id_usuario, this.scaffoldkey});
  @override
  Widget build(BuildContext context) {
    UsuarioGerenciador usuarioGerenciador = Provider.of(context);
    bool usuarioProprietario = false;
    if (id_usuario == usuarioGerenciador.auth.currentUser.uid) {
      usuarioProprietario = true;
    }

    return Container(
      child: Column(
        children: [
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Get.back();
                    }),
                Text(' '),
                usuarioProprietario
                    ? Container(
                        margin: EdgeInsets.only(right: 10),
                        child: GestureDetector(
                          child: Text("Excluir perfil",
                              style: TextStyle(color: Colors.red)),
                          onTap: () {
                            scaffoldkey.currentState
                                .showBottomSheet((context) => Container(
                                      height: 200,
                                      margin:
                                          EdgeInsets.only(left: 5, right: 5),
                                      padding: EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30),
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Tem certeza que deseja excluir esse perfil?",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                          Container(
                                            margin: EdgeInsets.all(20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  child: Text("cancelar", style: TextStyle(color: Colors.white, fontSize: 16),),
                                                  onTap: () {
                                                    Get.back();
                                                  },
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(30),
                                                    ),
                                                  ),
                                                  margin:
                                                      EdgeInsets.only(left: 20),
                                                  padding: EdgeInsets.only(
                                                      left: 15,
                                                      right: 15,
                                                      bottom: 10,
                                                      top: 10),
                                                  child: GestureDetector(
                                                    child: Text("excluir", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                                                    onTap: () {
                                                      // usuarioGerenciador.auth.currentUser.delete();
                                                    },
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ));
                          },
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text("curso",
                            style: TextStyle(color: Colors.grey, fontSize: 12)),
                        Text(usuario.curso ?? '-',
                            style: TextStyle(
                              color: Colors.teal,
                            ))
                      ],
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundImage: NetworkImage(usuario.imagem),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(
                            usuario.nome,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text("periodo",
                            style: TextStyle(color: Colors.grey, fontSize: 12)),
                        Text(usuario.periodo ?? '-',
                            style: TextStyle(
                              color: Colors.teal,
                            ))
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 6,
                  ),
                  child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      usuario.biografia,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(
                  height: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Divider(),
                      usuarioProprietario
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  child: Column(children: [
                                    Icon(
                                      Icons.edit,
                                      color: Colors.teal,
                                      size: 16,
                                    ),
                                    Text(
                                      "Editar Perfil",
                                      style: TextStyle(
                                          color: Colors.teal, fontSize: 14),
                                    )
                                  ]),
                                  onTap: () {
                                    Get.to(PerfilEdicao(
                                        id_usuario: id_usuario,
                                        usuario: usuario));
                                  },
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  child: Column(children: [
                                    Icon(
                                      Icons.send,
                                      color: Colors.teal,
                                      size: 16,
                                    ),
                                    Text(
                                      "Enviar Mensagem",
                                      style: TextStyle(
                                          color: Colors.teal, fontSize: 14),
                                    )
                                  ]),
                                  onTap: () {
                                    print('ENVIAR MENSAGEM');
                                  },
                                ),
                                GestureDetector(
                                  child: Column(children: [
                                    Icon(
                                      Icons.people,
                                      color: Colors.teal,
                                      size: 16,
                                    ),
                                    Text("Adicionar a um clube",
                                        style: TextStyle(
                                            color: Colors.teal, fontSize: 14))
                                  ]),
                                  onTap: () {
                                    print('ADIOCNEI AO CLUBE');
                                  },
                                )
                              ],
                            )
                    ],
                  ),
                )
              ],
            ),
            height: 240,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300],
            offset: Offset(0.0, 0.5), //(x,y)
            blurRadius: 6.0,
          ),
        ],
      ),
      margin: EdgeInsets.only(bottom: 3),
    );
  }
}
