import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:ifs_network/screens/login.dart';
import 'package:splashscreen/splashscreen.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SplashScreen(
          seconds: 4,
          routeName: "/",
          backgroundColor: Colors.teal,
          navigateAfterSeconds: Login(),
          loaderColor: Colors.transparent,
        ),
        Container(
          child: Center(
            child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                fadeInCurve: Curves.easeInCirc,
                image: 'https://i.ibb.co/VmqNwHG/ifsnetwork.png',
                fit: BoxFit.cover),
          ),
        )
      ],
    );
  }
}
