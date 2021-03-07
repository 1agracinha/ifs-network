import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:ifs_network/managers/usuario_gerenciador.dart';
import 'package:ifs_network/screens/home.dart';
import 'package:ifs_network/screens/login.dart';

class FormCadastro extends StatelessWidget {
  final Usuario usuario = Usuario();

  GlobalKey<FormState> formkey;
  GlobalKey<ScaffoldState> scaffoldkey;

  FormCadastro(this.formkey, this.scaffoldkey);

  @override
  Widget build(BuildContext context) {
    return Consumer<UsuarioGerenciador>(builder: (_, usuarioGerenciador, __) {
      return ListView(
        children: [
          Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email IFS',
                  suffixText: '*',
                  suffixStyle: TextStyle(
                    color: Colors.red,
                  ),
                ),
                validator: (email) {
                  if (email.isEmpty)
                    return 'Campo Obrigatório!';
                  else if (!email.contains('ifs.edu.br'))
                    return 'O e-mail deve ser de domínio do IFS';
                  return null;
                },
                onSaved: (email) => usuario.email = email,
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  labelText: 'Nome',
                  labelStyle: TextStyle(),
                  suffixText: '*',
                  suffixStyle: TextStyle(
                    color: Colors.red,
                  ),
                ),
                validator: (nome) {
                  if (nome.isEmpty) return 'Campo Obrigatório!';
                  return null;
                },
                onSaved: (nome) => usuario.nome = nome,
              ),
              TextFormField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Celular',
                ),
                onSaved: (celular) => usuario.celular = celular,
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  labelText: 'Biografia',
                  labelStyle: TextStyle(),
                ),
                maxLength: 100,
                onSaved: (biografia) => usuario.biografia = biografia,
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  suffixText: '*',
                  suffixStyle: TextStyle(
                    color: Colors.red,
                  ),
                ),
                validator: (senha) {
                  if (senha.isEmpty)
                    return 'Campo Obrigatório!';
                  else if (senha.length < 6) return 'Senha muito curta!';
                  return null;
                },
                onSaved: (senha) => usuario.senha = senha,
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirmar senha',
                  suffixText: '*',
                  suffixStyle: TextStyle(
                    color: Colors.red,
                  ),
                ),
                onSaved: (senha) => usuario.confirmarSenha = senha,
              ),
              Container(
                width: MediaQuery.of(context).size.height * 0.8,
                height: 40,
                margin: EdgeInsets.only(top: 20),
                child: RaisedButton(
                  child: Container(
                    child: Text(
                      'Cadastrar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  color: Theme.of(context).primaryColor,
                  disabledColor: Theme.of(context).primaryColor,
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7)),
                  onPressed: () {
                    if (formkey.currentState.validate()) {
                      formkey.currentState.save();
                    }
                    if (usuario.senha != usuario.confirmarSenha) {
                      scaffoldkey.currentState.showSnackBar(SnackBar(
                        content: const Text('Senhas não coincidem!!'),
                        backgroundColor: Colors.red,
                      ));
                    } else {
                      context.read<UsuarioGerenciador>().cadastrar(
                            usuario: usuario,
                            onSuccess: () {
                              scaffoldkey.currentState.showSnackBar(SnackBar(
                                content: const Text('Usuário Cadastrado!'),
                                backgroundColor: Colors.green,
                              ));
                              Get.off(Home());
                            },
                            onFail: (e) {
                              scaffoldkey.currentState.showSnackBar(SnackBar(
                                content: const Text('Falha ao cadastrar'),
                                backgroundColor: Colors.red,
                              ));
                            },
                          );
                    }
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.height * 0.8,
                height: 40,
                child: RaisedButton(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7)),
                    onPressed: () {
                      Get.to(Login(), transition: Transition.zoom);
                    },
                    child: Text(
                      'Já tem uma conta?',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    )),
              )
            ],
          ),
        ],
      );
    });
  }
}
