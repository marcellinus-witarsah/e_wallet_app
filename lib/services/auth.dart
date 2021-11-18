//for authentication services

import 'package:e_wallet_app/model/user_model.dart';
import 'package:e_wallet_app/services/result_status.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //create a Firebase Auth instance for interacting with Firebase Auth services
  //final= mean that this is a final and private variable
  final FirebaseAuth _authInstance;
  late AuthResultStatus _status;

  AuthService(this._authInstance);

  FirebaseAuth get authInstance {
    return this._authInstance;
  }

  UserModel? _userFromFirebase(User? user) {
    return user != null ? UserModel(user.uid) : null;
  }

  Stream<UserModel?> get onAuthStateChanged {
    return _authInstance.authStateChanges().map(_userFromFirebase);
  }

  //sign up
  Future<AuthResultStatus> SignUpAccount(String email, String password) async {
    try {
      //using firebase function through Firebase Auth instance for sign up
      final authResult = await _authInstance.createUserWithEmailAndPassword(
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
      final authResult = await _authInstance.signInWithEmailAndPassword(
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
    return _authInstance.signOut();
  }
}
