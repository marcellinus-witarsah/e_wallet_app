import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_wallet_app/model/user_model.dart';
import 'package:e_wallet_app/services/auth.dart';
import 'package:e_wallet_app/services/db.dart';
import 'package:e_wallet_app/view/home_page.dart';
import 'package:e_wallet_app/view/signin_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// To check if user already sign in or not
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<AuthService>(context);
    final _db = Provider.of<DatabaseService>(context);
    return StreamBuilder(
      stream: _auth.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          UserModel user = snapshot.data as UserModel;
          if (user != null) {
            // UserModel userModel = UserModel(email: user.uid, uid: user.uid);
            return ChangeNotifierProvider<UserModel>(
              create: (context) => user,
              child: Homepage(),
            );
          }
          return SignIn();
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

// StreamBuilder(
//         stream: _auth.authInstance.authStateChanges(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.active) {
//             if (snapshot.data != null) {
//               User user = snapshot.data as User;
//               return FutureBuilder(
//                 future: _db.users.doc(user.uid).get(),
//                 builder: (
//                   BuildContext context,
//                   AsyncSnapshot<DocumentSnapshot> snapshot,
//                 ) {
//                   if (snapshot.connectionState == ConnectionState.done) {
//                     Map<String, dynamic> data =
//                         snapshot.data!.data() as Map<String, dynamic>;
//                     return Provider<UserModel>(
//                         create: (_) => UserModel(
//                               uid: data['uid'],
//                               email: data['email'],
//                             ),
//                         child: Homepage());
//                   }
//                   return CircularProgressIndicator();
//                 },
//               );
//             } else {
//               return SignIn();
//             }
//           }
//           return CircularProgressIndicator();
//         });