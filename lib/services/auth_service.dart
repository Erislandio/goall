import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class BaseAuth {
  Future<String> signIn(String email, String password);

  Future<String> signUp(String email, String password);

  Future<FirebaseUser> getCurrentUser();

  Future<void> sendEmailVerification();

  Future<void> signOut();

  Future<bool> isEmailVerified();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<String> signIn(String email, String password) async {
    String errorMessage;

    try {
      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (error) {
      switch (error.code) {
        case "ERROR_INVALID_EMAIL":
          errorMessage = "Digite um e-mail válido!";
          break;
        case "ERROR_WRONG_PASSWORD":
          errorMessage = "Senha incorreta!";
          break;
        case "ERROR_USER_NOT_FOUND":
          errorMessage = "Usuário não encontrado!.";
          break;
        case "ERROR_USER_DISABLED":
          errorMessage = "Usuário está bloqueado!";
          break;
        default:
          errorMessage =
              "Ops! não foi possível fazer o login no momento, tente novamente!";
      }
    }

    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
  }

  Future<String> googleSignIn() async {
    try {
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final AuthResult authResult =
          await _firebaseAuth.signInWithCredential(credential);

      FirebaseUser user = authResult.user;
      return user.uid;
    } catch (e) {
      throw e;
    }
  }

  void signOutGoogle() async {
    await _googleSignIn.signOut();
  }

  Future<String> signUp(String email, String password) async {
    String errorMessage;

    try {
      AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return user.uid;
    } catch (error) {
      switch (error.code.toString().toLowerCase()) {
        case "error_email_already_in_use":
          errorMessage = "Esse e-email já está sendo utilizado";
          break;
        case "error_invalid_email":
          errorMessage = "Digite um e-mail válido!";
          break;
        default:
          errorMessage =
              "Ops! aconteceu algum erro ao tentar criar a conta, tente novamente.";
      }
    }

    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }
}
