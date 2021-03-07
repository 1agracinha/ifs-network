import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ifs_network/screens/login.dart';

class AguardeEmail extends StatelessWidget {
  String email;
  AguardeEmail({this.email});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sucesso!!",
                style: TextStyle(color: Colors.white, fontSize: 40),
                textAlign: TextAlign.center,
              ),
              Container(
                  margin: EdgeInsets.only(top: 10, bottom: 40),
                  height: 120,
                  child: Image.asset("assets/senha.gif")),
              Text(
                "Um link de recuperação será enviado para",
                style: TextStyle(color: Colors.white, fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                email,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: 20),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 40,
              ),
              RaisedButton(
                  child: Text(
                    "Ir para login",
                    style: TextStyle(color: Colors.teal),
                  ),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.only(right: 100, left: 100),
                  onPressed: () => Get.to(Login()))
            ],
          ),
        ),
      ),
    );
  }
}
