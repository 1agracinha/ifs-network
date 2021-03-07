import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';

import 'package:ifs_network/screens/criar_postagem.dart';

SpeedDialChild criarPostBtn(String label, IconData icon, BuildContext context) {
  return SpeedDialChild(
    child: Icon(icon, color: Colors.white),
    backgroundColor: Colors.teal,
    onTap: () => Get.to(CriarPostagem(), transition: Transition.rightToLeft, duration: Duration(milliseconds: 500)),
    label: label,
    labelStyle: TextStyle(fontWeight: FontWeight.w500, color: Colors.teal[900]),
    labelBackgroundColor: Colors.teal[100],
  );
}

SpeedDialChild enviarMensagemBtn(
    String label, IconData icon, BuildContext context) {
  return SpeedDialChild(
    child: Icon(icon, color: Colors.white),
    backgroundColor: Colors.teal[50],
    onTap: () => () {},
    label: label,
    labelStyle: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
    labelBackgroundColor: Colors.teal[50],
  );
}

SpeedDialChild criarClubeBtn(
    String label, IconData icon, BuildContext context) {
  return SpeedDialChild(
    child: Icon(icon, color: Colors.white),
    backgroundColor: Colors.teal[50],
    onTap: () => () {},
    label: label,
    labelStyle: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
    labelBackgroundColor: Colors.teal[50],
  );
}
