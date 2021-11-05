//for authentication services
import 'package:e_wallet_app/model/user_model.dart';
import 'package:e_wallet_app/services/result_status.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';

class AuthService {
  //create a Firebase Auth instance for interacting with Firebase Auth services
  //final= mean that this is a final and private variable
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late AuthResultStatus _status;

  FirebaseAuth getAuthInstance() {
    return _auth;
  }

  //sign up
  Future<AuthResultStatus> SignUpAccount(String email, String password) async {
    try {
      //using firebase function through Firebase Auth instance for sign up
      final authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (authResult.user != null) {
        _status = AuthResultStatus.successful;
      } else {
        _status = AuthResultStatus.undefined;
      }
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status;
  }

  //log in
  Future<AuthResultStatus> SignInAccount(String email, String password) async {
    try {
      //using firebase function through Firebase Auth instance for sign in
      final authResult = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (authResult.user != null) {
        _status = AuthResultStatus.successful;
      } else {
        _status = AuthResultStatus.undefined;
      }
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status;
  }

  //sign out
  Future SignOutAccount() async {
    //using firebase function through Firebase Auth instance for sign out
    return _auth.signOut();
  }
}
