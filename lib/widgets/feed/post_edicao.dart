import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import 'package:ifs_network/managers/posts_provider.dart';
import 'package:ifs_network/managers/usuario_gerenciador.dart';
import 'package:ifs_network/screens/home.dart';

class PostEdicao extends StatefulWidget {
  GlobalKey<ScaffoldState> scaffoldkey;
  final Map<String, dynamic> postMap;
  Usuario usuario;
  var docPostagem;

  PostEdicao({this.usuario, this.postMap, this.docPostagem, this.scaffoldkey});
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController textoPostController = TextEditingController();
  @override
  _PostEdicaoState createState() => _PostEdicaoState();
}

class _PostEdicaoState extends State<PostEdicao> {
  bool _expanded = false;

  bool clicou = false;
  CollectionReference postagens =
      FirebaseFirestore.instance.collection('postagens');

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

  bool imagemBanco() {
    if (widget.usuario.imagem == null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    UsuarioGerenciador usuarioGerenciador = Provider.of(context);
    Postagens postagem = Provider.of(context);
    String dataString = widget.postMap['data_postagem'] as String;
    DateTime data = DateTime.parse(dataString);

    String dataPostagem = DateFormat('dd-MM-yyyy – kk:mm').format(data);

    Future uploadPic(BuildContext context) async {
      String fileName = _image.path.split('/').last;
      var ref = FirebaseStorage.instance.ref().child(fileName);
      await ref.putFile(_image);
      return await ref.getDownloadURL();
    }

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () => Get.back()),
          title: Text(
            "Editar postagem",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: ListView(
          children: [
            Card(
              color: Colors.white,
              margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
              shadowColor: Colors.grey[50],
              child: Column(
                children: [
                  Container(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 60,
                            color: Colors.grey[100],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: CircleAvatar(
                                        backgroundImage: imagemBanco()
                                            ? NetworkImage(
                                                'https://cdn.icon-icons.com/icons2/1154/PNG/512/1486564400-account_81513.png')
                                            : NetworkImage(
                                                widget.usuario.imagem),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: Text(widget.usuario.nome),
                                    )
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: Text(
                                    dataPostagem,
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 10),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 10),
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.add_a_photo,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () {
                                      getImageCam();
                                    },
                                  ),
                                  Container(
                                    width: 100,
                                    height: 60,
                                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                    child: imagemNull()
                                        ? Image.network(
                                            widget.postMap['imagem'].toString())
                                        : Image.file(_image),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.add_photo_alternate,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () {
                                      getImageGallery();
                                    },
                                  ),
                                ],
                              )),
                          Divider(),
                          Container(

                            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),

                            child: Column(children: [
                              Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Container(
                                    height: MediaQuery.of(context).size.height * 0.5,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        hintText: widget.postMap['texto'],
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                      ),
                                      onTap: () {
                                        clicou
                                            ? null
                                            : widget.textoPostController.text =
                                                widget.postMap['texto'];
                                        setState(() {
                                          _expanded = true;
                                          clicou = true;
                                        });
                                      },
                                      maxLength: 1000,
                                      expands: true,
                                      minLines: null,
                                      maxLines: null,
                                      controller: widget.textoPostController,
                                      keyboardType: TextInputType.multiline,
                                    ),
                                  )),
                            ]),
                          ),
                          FlatButton(
                              onPressed: () async {
                                var link;
                                imagemNull()
                                    ? link = widget.postMap['imagem'].toString()
                                    : link = await uploadPic(context);

                                postagem.editarPostagem(
                                    texto: widget.textoPostController.text,
                                    id_postagem: widget.docPostagem,
                                    imagem: link);
                                Get.to(Home());
                              },
                              child: Text(
                                "Salvar",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ))
                        ]),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
