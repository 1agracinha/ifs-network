import 'package:flutter/material.dart';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:ifs_network/screens/feed.dart';
import 'package:ifs_network/widgets/feed/floating_button.dart';


class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin {

  SpeedDial buildSpeedDial(BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(
        size: 22.0,
      ),
      backgroundColor: Colors.teal,

      children: [
        criarPostBtn('Criar Postagem', Icons.add, context),
        enviarMensagemBtn('Enviar Mensagem', Icons.forum, context),
        criarClubeBtn('Criar Clube', Icons.people, context)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Feed(), floatingActionButton: buildSpeedDial(context));
  }
}
