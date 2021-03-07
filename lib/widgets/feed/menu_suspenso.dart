import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:ifs_network/managers/usuario_gerenciador.dart';
import 'package:ifs_network/screens/login.dart';
import 'package:ifs_network/screens/perfil.dart';

class MenuSuspenso extends StatelessWidget {
  Usuario usuario;

  @override
  Widget build(BuildContext context) {
    UsuarioGerenciador usuarioGerenciador = Provider.of(context);

    return SingleChildScrollView(
      child: Consumer<UsuarioGerenciador>(
        builder: (_, usuarioGerenciador, __) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(children: [
                IconButton(
                    icon: Icon(
                      Icons.person,
                      color: Theme.of(context).primaryColor,
                      size: 35,
                    ),
                    onPressed: () async {
                      usuario = await usuarioGerenciador.pegarUsuarioPorId(
                          usuarioGerenciador.auth.currentUser.uid);
                      Get.to(Perfil(
                        usuario: usuario,
                        id_usuario: usuarioGerenciador.auth.currentUser.uid,
                      ), transition: Transition.upToDown, duration: Duration(milliseconds: 500));
                    }),
                Text("Perfil",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 14,
                    ))
              ]),
              Column(children: [
                IconButton(
                    icon: Icon(
                      Icons.notifications,
                      color: Colors.teal[50], //Theme.of(context).primaryColor,
                      size: 35,
                    ),
                    onPressed: null),
                Text("Notificações",
                    style: TextStyle(
                      color: Colors.teal[50], //Theme.of(context).primaryColor,
                      fontSize: 14,
                    ))
              ]),
              Column(children: [
                IconButton(
                    icon: Icon(
                      Icons.people,
                      color: Colors.teal[50], //Theme.of(context).primaryColor,
                      size: 35,
                    ),
                    onPressed: () {}),
                Text("Clubes",
                    style: TextStyle(
                      color: Colors.teal[50], //Theme.of(context).primaryColor,
                      fontSize: 14,
                    ))
              ]),
              Column(
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.exit_to_app,
                        color: Theme.of(context).primaryColor,
                        size: 35,
                      ),
                      onPressed: () {
                        // Get.off(Login());
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (ctx) => Login()));
                        usuarioGerenciador.sair();
                      }),
                  Text(
                    "Sair",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 14,
                    ),
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
