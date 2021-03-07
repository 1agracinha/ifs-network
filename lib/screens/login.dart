import 'dart:ui';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:ifs_network/managers/usuario_gerenciador.dart';
import 'package:ifs_network/screens/home.dart';
import '../widgets/login/card_login.dart';

class Login extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    UsuarioGerenciador usuario = Provider.of(context);
    return Scaffold(
      key: scaffoldkey,
      body: usuario.estaLogado
          ? Home()
          : Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/alunos.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                    child: Container(
                      color: Colors.white.withOpacity(0.4),
                    ),
                  ),
                ),
                Container(
                  child: CardLogin(scaffoldkey),
                ),
              ],
            ),
    );
  }
}
