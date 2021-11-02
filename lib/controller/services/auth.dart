//for authentication services
import 'package:e_wallet_app/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';

class AuthService {
  //create a Firebase Auth instance for interacting with Firebase Auth services
  //_auth = mean that this is a final and private variable
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseAuth getAuthInstance() {
    return _auth;
  }
  // //to check if our user model is null or not
  // UserModel? _userFromFirebase(User? user) {
  //   if (user == null) {
  //     return null;
  //   }
  //   return UserModel(
  //     uid: user.uid,
  //     email: user.email.toString(),
  //   );
  // }

  // Stream<UserModel?>? get user {
  //   return _auth.authStateChanges().map(_userFromFirebase);
  // }

  //sign up
  Future SignUpAccount(
    String email,
    String password,
  ) async {
    final result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user;
  }

  //log in
  Future SignInAccount(
    String email,
    String password,
  ) async {
    final result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user;
  }

  //sign out
  Future SignOutAccount() async {
    return _auth.signOut();
  }
}
