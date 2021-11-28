//for authentication services

import 'package:e_wallet_app/model/user_model.dart';
import 'package:e_wallet_app/services/result_status.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthService {
  FirebaseAuth get authInstance;
  UserModel? _userFromFirebase(User? user);
  Stream<UserModel?> get user;
  Future<UserModel?> SignUpAccount(String email, String password);
  Future<UserModel?> SignInAccount(String email, String password);
  Future SignOutAccount();
}
