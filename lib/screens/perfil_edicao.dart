import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:ifs_network/managers/usuario_gerenciador.dart';
import 'package:ifs_network/screens/home.dart';

class PerfilEdicao extends StatefulWidget {
  Usuario usuario;
  String id_usuario;
  PerfilEdicao({this.usuario, this.id_usuario});

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController nomeController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController cursoController = TextEditingController();
  TextEditingController periodoController = TextEditingController();
  TextEditingController imgController = TextEditingController();

  @override
  _PerfilEdicaoState createState() => _PerfilEdicaoState();
}

class _PerfilEdicaoState extends State<PerfilEdicao> {
  File _image;
  final picker = ImagePicker();

  Future getImageCam() async {
    final PickedFile imagemSelecionada =
        await picker.getImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      if (imagemSelecionada != null) {
        _image = File(imagemSelecionada.path);
      } else {
        print('SEM IMAGEM SELECIONADA');
      }
    });
  }

  Future getImageGallery() async {
    final PickedFile imagemSelecionada =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      if (imagemSelecionada != null) {
        _image = File(imagemSelecionada.path);
      } else {
        print('SEM IMAGEM SELECIONADA');
      }
    });
  }

  bool imagemNull() {
    if (_image == null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    UsuarioGerenciador usuarioGerenciador = Provider.of(context);

    Future uploadPic(BuildContext context) async {
      String fileName = _image.path.split('/').last;
      var ref = FirebaseStorage.instance.ref().child(fileName);
      await ref.putFile(_image);
      return await ref.getDownloadURL();
    }

    bool carregando = false;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () => Get.back()),
        title: Text(
          "Editar Perfil",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: carregando
          ? Container(
              height: MediaQuery.of(context).size.height * 1,
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.teal),
                ),
              ),
            )
          : GestureDetector(
              child: ListView(
                children: [
                  Form(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                icon: Icon(Icons.add_a_photo,
                                    color: Theme.of(context).primaryColor),
                                onPressed: () {
                                  getImageCam();
                                },
                              ),
                              Container(
                                width: 60,
                                height: 80,
                                child: imagemNull()
                                    ? Image.network(widget.usuario.imagem)
                                    : Image.file(_image),
                              ),
                              IconButton(
                                icon: Icon(Icons.add_photo_alternate,
                                    color: Theme.of(context).primaryColor),
                                onPressed: () {
                                  getImageGallery();
                                },
                              ),
                            ],
                          ),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: "Nome",
                              hintText: widget.usuario.nome,
                              suffixText: '*',
                              suffixStyle: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                            controller: widget.nomeController,
                            onTap: () {
                              widget.nomeController.text = widget.usuario.nome;
                            },
                          ),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: "Curso",
                              hintText: widget.usuario.curso,
                              suffixText: '*',
                              suffixStyle: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                            controller: widget.cursoController,
                            onTap: () {
                              widget.cursoController.text =
                                  widget.usuario.curso;
                            },
                          ),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: "Período",
                              hintText: widget.usuario.periodo,
                              suffixText: '*',
                              suffixStyle: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                            controller: widget.periodoController,
                            onTap: () {
                              widget.periodoController.text =
                                  widget.usuario.periodo;
                            },
                          ),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: "Biografia",
                              hintText: widget.usuario.biografia,
                              suffixText: '*',
                              suffixStyle: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                            controller: widget.bioController,
                            onTap: () {
                              widget.bioController.text =
                                  widget.usuario.biografia;
                            },
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            child: Center(
                                child: RaisedButton(
                              color: Theme.of(context).primaryColor,
                              child: Text(
                                "Salvar",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                if (widget.bioController.text == "") {
                                  widget.bioController.text =
                                      widget.usuario.biografia;
                                }
                                if (widget.nomeController.text == "") {
                                  widget.nomeController.text =
                                      widget.usuario.nome;
                                }
                                if (widget.periodoController.text == "") {
                                  widget.periodoController.text =
                                      widget.usuario.periodo;
                                }
                                if (widget.cursoController.text == "") {
                                  widget.cursoController.text =
                                      widget.usuario.curso;
                                }

                                setState(() {
                                  carregando = true;
                                });
                                var link;
                                imagemNull()
                                    ? link = widget.usuario.imagem
                                    : link = await uploadPic(context);
                                try {
                                  context
                                      .read<UsuarioGerenciador>()
                                      .editarUsuario(
                                          usuario: Usuario(
                                              id: usuarioGerenciador
                                                  .auth.currentUser.uid,
                                              nome: widget.nomeController.text,
                                              biografia:
                                                  widget.bioController.text,
                                              curso:
                                                  widget.cursoController.text,
                                              periodo:
                                                  widget.periodoController.text,
                                              imagem: link));

                                  Get.to(Home());
                                } catch (e) {}
                              },
                            )),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
