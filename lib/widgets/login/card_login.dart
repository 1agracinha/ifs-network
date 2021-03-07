import 'package:flutter/material.dart';
import 'form_login.dart';

class CardLogin extends StatelessWidget {
  GlobalKey<ScaffoldState> scaffoldkey;

  CardLogin(this.scaffoldkey);
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                      height: 60,
                      margin: EdgeInsets.only(top: 26),
                      child: Image(
                        image: AssetImage('assets/ifsnetwork.png'),
                      )),
                ),
              ],
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.width * 1.2,
                margin: EdgeInsets.only(top: 100),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(255, 255, 255, 0.5)),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
                    child: FormLogin(scaffoldkey),
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
