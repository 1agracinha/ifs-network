import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:ifs_network/managers/comentarios_provider.dart';
import 'package:ifs_network/managers/posts_provider.dart';
import 'package:ifs_network/managers/usuario_gerenciador.dart';
import 'package:ifs_network/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UsuarioGerenciador()),
        ChangeNotifierProvider(create: (_) => Postagens()),
        ChangeNotifierProvider(create: (_) => Comentarios()),
      ],
      child: GetMaterialApp(
        title: 'IFS NETWORK',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.teal[300],
          cursorColor: Colors.teal,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Splash(),
      ),
    );
  }
}
