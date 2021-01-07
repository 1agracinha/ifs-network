import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:ifs_network/managers/usuario_gerenciador.dart';
import 'package:ifs_network/screens/cadastro.dart';
import 'package:ifs_network/screens/home.dart';
import 'package:ifs_network/screens/recuperar_senha.dart';

//TODO: deixar o tamAnho ajustavel
class FormLogin extends StatefulWidget {
  GlobalKey<ScaffoldState> scaffoldkey;

  FormLogin(this.scaffoldkey);

  @override
  _FormLoginState createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<UsuarioGerenciador>(builder: (_, usuarioGerenciador, __) {
      return Form(
        key: formkey,
        child: ListView(
          children: [
            Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  showCursor: true,
                  decoration: InputDecoration(
                      labelText: 'E-mail IFS',
                      suffixText: '*',
                      suffixStyle: TextStyle(
                        color: Colors.red,
                      ),
                      icon: Icon(Icons.mail)),
                  validator: (email) {
                    if (email.isEmpty) {
                      return 'Campo Obrigatório!';
                    } else if (!email.contains('ifs.edu.br')) {
                      return 'E-mail inválido!';
                    } else
                      return null;
                  },
                  controller: emailController,
                  enabled: !usuarioGerenciador.loading,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: 'Senha',
                      suffixText: '*',
                      suffixStyle: TextStyle(
                        color: Colors.red,
                      ),
                      icon: Icon(Icons.vpn_key)),
                  validator: (senha) {
                    if (senha.isEmpty) {
                      return 'Campo Obrigatório!';
                    } else if (senha.length < 6) {
                      return 'Senha Incorreta!';
                    } else
                      return null;
                  },
                  controller: senhaController,
                  enabled: !usuarioGerenciador.loading,
                ),
                Container(
                  margin: EdgeInsets.only(top: 40),
                  width: MediaQuery.of(context).size.height * 0.8,
                  height: 40,
                  child: RaisedButton(
                    child: Container(
                      child: usuarioGerenciador.loading
                          ? SizedBox(
                              width: 15,
                              height: 15,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(Colors.teal),
                                strokeWidth: 1,
                              ),
                            )
                          : Center(
                              child: Text(
                                'Entrar',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                    ),
                    color: Theme.of(context).primaryColor,
                    disabledColor:
                        Theme.of(context).primaryColor.withAlpha(100),
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7)),

                    //BOTAO PRESS
                    onPressed: usuarioGerenciador.loading
                        ? null
                        : () {
                            if (formkey.currentState.validate()) {
                              context.read<UsuarioGerenciador>().logar(
                                  usuario: Usuario(
                                    email: emailController.text,
                                    senha: senhaController.text,
                                  ),
                                  onFail: (e) {
                                    widget.scaffoldkey.currentState
                                        .showSnackBar(SnackBar(
                                      content: Text('Falha ao entrar: $e'),
                                      backgroundColor: Colors.red,
                                    ));
                                  },
                                  onSuccess: () {
                                    widget.scaffoldkey.currentState
                                        .showSnackBar(SnackBar(
                                      content: Text('Sucesso!'),
                                      backgroundColor: Colors.green,
                                      duration: Duration(milliseconds: 600),
                                    ));
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) => Home()),
                                        (Route<dynamic> route) => false);
                                    ;
                                  });
                            }
                          },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 15),
                  child: GestureDetector(
                    child: Text(
                      "Esqueceu sua senha?",
                      style: TextStyle(
                          color: Colors.teal, fontWeight: FontWeight.w700),
                    ),
                    onTap: () {
                      Get.to(RecuperarSenha());
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: (Row(
                    children: <Widget>[
                      Expanded(
                          child: Divider(
                        color: Colors.grey,
                        indent: 30,
                        endIndent: 7,
                      )),
                      Text(
                        "OU",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.grey,
                          indent: 7,
                          endIndent: 30,
                        ),
                      ),
                    ],
                  )),
                ),
                Container(
                  width: MediaQuery.of(context).size.height * 0.8,
                  height: 40,
                  margin: EdgeInsets.only(top: 10),
                  child: Hero(
                    tag: "conta",
                    child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)),
                        onPressed: () {
                          Get.to(Cadastro());
                        },
                        child: Text(
                          'Não tem uma conta?',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        )),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
