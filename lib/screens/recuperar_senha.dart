import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:ifs_network/managers/usuario_gerenciador.dart';
import 'package:ifs_network/widgets/recuperar_senha/aguarde_email.dart';

class RecuperarSenha extends StatelessWidget {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UsuarioGerenciador usuarioGerenciador = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.grey,
            onPressed: () => Get.back()),
        title: Text(
          "Recuperar senha",
          style: TextStyle(color: Colors.grey[600]),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20, left: 40, right: 40),
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: 200,
              height: 230,
              child: Image.asset("assets/pass.png"),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Esqueceu sua senha?",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).primaryColor),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Por favor, informe o e-mail associado a sua conta que enviaremos um link para o mesmo com as instruções para restauração de sua senha",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Form(
              key: formkey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "E-mail",
                      labelStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    controller: emailController,
                    validator: (email) {
                      if (email.isEmpty) {
                        return 'Campo Obrigatório!';
                      } else if (!email.contains('ifs.edu.br')) {
                        return 'E-mail inválido!';
                      } else
                        return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 40,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    child: SizedBox.expand(
                      child: FlatButton(
                        child: Text(
                          "Enviar",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {
                          if (formkey.currentState.validate()) {
                            usuarioGerenciador
                                .recuperarSenha(emailController.text);
                            Get.to(AguardeEmail(
                              email: emailController.text,
                            ));
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
