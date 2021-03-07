import 'package:flutter/material.dart';

import './form_cadastro.dart';

class CardCadastro extends StatelessWidget {
  GlobalKey<ScaffoldState> scaffoldkey;

  CardCadastro(this.scaffoldkey);

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: ListView(
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
                        margin: EdgeInsets.only(top: 12),
                        child: Image(
                          image: AssetImage('assets/ifsnetwork.png'),
                        )),
                  ),
                ],
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.width * 1.5,
                  margin: EdgeInsets.only(top: 50),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromRGBO(255, 255, 255, 0.6)),
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: FormCadastro(formkey, scaffoldkey),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
