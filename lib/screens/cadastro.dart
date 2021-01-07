import 'dart:ui';
import 'package:flutter/material.dart';

import '../widgets/cadastro/card_cadastro.dart';

class Cadastro extends StatelessWidget {

  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      body:Stack(
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
            child: CardCadastro(scaffoldkey),
          ),
        ],
      ),
    );
  }
}