import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ifs_network/helpers/firebase_erros.dart';

class Usuario {
  Usuario(
      {this.id,
      this.nome,
      this.imagem,
      this.email,
      this.senha,
      this.celular,
      this.biografia,
      this.periodo,
      this.curso});

  Usuario.fromDocument(DocumentSnapshot document) {
    id = document.id;
    nome = document.data()['nome'] as String;
    imagem = document.data()['imagem'] as String;
    email = document.data()['email'] as String;
    celular = document.data()['celular'] as String;
    biografia = document.data()['biografia'] as String;
    curso = document.data()['curso'] as String;
    periodo = document.data()['periodo'] as String;
  }

  String id,
      nome,
      imagem,
      email,
      senha,
      celular,
      confirmarSenha,
      biografia,
      periodo,
      curso;

  DocumentReference get firestoreRef =>
      FirebaseFirestore.instance.doc('usuarios/$id');

  Future<void> salvarDados() async {
    await firestoreRef.set(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'email': email,
      'celular': celular,
      'biografia': biografia,
      'periodo': periodo,
      'curso': curso
    };
  }
}

//================================================================

class UsuarioGerenciador with ChangeNotifier {
  UsuarioGerenciador() {
    _loadCurrentUser();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Usuario usuario;

  bool _loading = false;
  bool get loading => _loading;
  bool get estaLogado => usuario != null;

  Future<Usuario> pegarUsuarioPorId(String id) async {
    var request =
        await FirebaseFirestore.instance.collection('usuarios').doc(id).get();
    var usuarioMap = request.data();
    Usuario usuario = Usuario(
        id: id,
        imagem: usuarioMap['imagem'],
        nome: usuarioMap['nome'],
        celular: usuarioMap['celular'],
        email: usuarioMap['email'],
        biografia: usuarioMap['biografia'],
        periodo: usuarioMap['periodo'],
        curso: usuarioMap['curso']);
    return usuario;
  }
//LOGIN ===========================================================

  Future<void> logar(
      {Usuario usuario, Function onFail, Function onSuccess}) async {
    loading = true;

    try {
      final UserCredential result = await auth.signInWithEmailAndPassword(
          email: usuario.email, password: usuario.senha);

      usuario.id = result.user.uid;
      this.usuario = usuario;
      print('result: ${usuario.nome}');

      onSuccess();
    } on FirebaseAuthException catch (e) {
      onFail(getErrorString(e.code));
      print(e);
    }
    loading = false;
  }

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> _loadCurrentUser({User firebaseUser}) async {
    User currentUser = auth.currentUser;

    if (currentUser != null) {
      final DocumentSnapshot docUsuario = firebaseUser ??
          await firestore.collection('usuarios').doc(currentUser.uid).get();

      usuario = Usuario.fromDocument(docUsuario);
      notifyListeners();
    }
  }

  void sair() {
    auth.signOut();
    usuario = null;

    notifyListeners();
  }

  @override
  Future<void> recuperarSenha(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }

//CADASTRO======================================================================
  Future<void> cadastrar(
      {Usuario usuario, Function onFail, Function onSuccess}) async {
    try {
      final UserCredential result = await auth.createUserWithEmailAndPassword(
          email: usuario.email, password: usuario.senha);

      usuario.id = result.user.uid;
      this.usuario = usuario;
      await usuario.salvarDados();

      onSuccess();
    } on PlatformException catch (e) {
      onFail(getErrorString(e.code));
    }
  }

  Future<void> editarUsuario({Usuario usuario}) async{
    try{
      await firestore.collection('usuarios').doc(usuario.id).update(
        {
          'nome': usuario.nome,
          'curso': usuario.curso,
          'periodo': usuario.periodo,
          'biografia': usuario.biografia,
          'imagem': usuario.imagem
        }
      );
    }catch(e){
      
    }
  }


}
