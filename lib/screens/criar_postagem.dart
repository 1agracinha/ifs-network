import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.Dart';

import 'package:ifs_network/managers/posts_provider.dart';
import '../managers/usuario_gerenciador.dart';

class CriarPostagem extends StatefulWidget {
  @override
  _CriarPostagemState createState() => _CriarPostagemState();
}

class _CriarPostagemState extends State<CriarPostagem> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  final TextEditingController textoController = TextEditingController();

  File _image;
  final picker = ImagePicker();

  var carregando = false;

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
    return Consumer<UsuarioGerenciador>(
      builder: (_, usuarioGerenciador, __) {
        Future uploadPic(BuildContext context) async {
          String fileName = _image.path.split('/').last;
          var ref = FirebaseStorage.instance.ref().child(fileName);
          await ref.putFile(_image);
          return await ref.getDownloadURL();
        }

        String id = usuarioGerenciador.auth.currentUser.uid;
        return Scaffold(
          key: scaffoldkey,
          appBar: AppBar(
            leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Theme.of(context).primaryColor,
            onPressed: () => Get.back()),
              backgroundColor: Colors.white,
              title: Center(
                  child: Text(
                'Criar Postagem',
                style: TextStyle(color: Colors.teal),
              ),)
              
              ,),
          body: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        icon: Icon(Icons.add_photo_alternate,
                            color: Colors.teal, size: 45),
                        onPressed: () {
                          getImageGallery();
                        }),
                    Container(
                      width: imagemNull() ? 0 : 100,
                      height:  imagemNull() ? 0 : 60,
                      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                      child: imagemNull() ? Container() : Image.file(_image),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                    ),
                  
                    IconButton(
                        icon: Icon(Icons.add_a_photo,
                            color: Colors.teal, size: 45),
                        onPressed: () {
                          getImageCam();
                        }),
                  ],
                ),
              ),
              Container(
                width: 390,
                height: 360,
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.fromLTRB(0, 80, 0, 50),
                child: Card(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      controller: textoController,
                      minLines: null,
                      maxLines: null,
                      maxLength: 1000,
                      expands: true,
                      decoration: InputDecoration(
                        labelText: 'No que você está pensando?',
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                  bottom: MediaQuery.of(context).viewInsets.top,
                  left: 0,
                  right: 0,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 15),
                          child: IconButton(
                              icon: Icon(Icons.cancel_outlined,
                                  size: 45, color: Colors.red[200]),
                              onPressed: () {
                                Get.back();
                              }),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 15),
                          child: IconButton(
                              icon: Icon(Icons.check_circle_outline,
                                  size: 45, color: Colors.teal[200]),
                              onPressed: () async {
                                setState(() {
                                  carregando = true;
                                });
                                SystemChannels.textInput
                                    .invokeMethod('TextInput.hide');
                                var link;
                                imagemNull()
                                    ? link = "Sem Imagem"
                                    : link = await uploadPic(context);

                                Usuario usuario = await usuarioGerenciador
                                    .pegarUsuarioPorId(usuarioGerenciador
                                        .auth.currentUser.uid);
                                try {
                                  context.read<Postagens>().criarPostagem(
                                        Post(
                                            id_usuario: id,
                                            dataPostagem: DateTime.now()
                                                .toIso8601String(),
                                            imgPath: link ?? "#",
                                            texto: textoController.text),
                                      );

                                  scaffoldkey.currentState
                                      .showSnackBar(SnackBar(
                                    content: const Text('Publicação feita!'),
                                    backgroundColor: Colors.green,
                                    duration: Duration(milliseconds: 600),
                                  ));

                                  Get.back();
                                } catch (e) {
                                  print('Error: $e');
                                  scaffoldkey.currentState
                                      .showSnackBar(SnackBar(
                                    content: const Text('Erro ao publicar!'),
                                    backgroundColor: Colors.red,
                                  ));
                                }
                              }),
                        )
                      ],
                    ),
                  )),
              carregando
                  ? Container(
                      height: MediaQuery.of(context).size.height * 1,
                      color: Colors.white,
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.teal),
                        ),
                      ),
                    )
                  : Container(
                      height: 0,
                    )
            ],
          ),
        );
      },
    );
  }
}
