import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_wallet_app/model/user_model.dart';
import 'package:e_wallet_app/services/auth_service.dart';
import 'package:e_wallet_app/services/firebase_database_service.dart';
import 'package:e_wallet_app/services/firebase_auth_service.dart';
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
    final FirebaseAuthService _auth = Provider.of<FirebaseAuthService>(context);
    final _userModel = Provider.of<UserModel?>(context);
    if (_userModel == null) {
      return SignIn();
    } else {
      return Homepage();
    }
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

    // return StreamBuilder(
    //   stream: _auth.onAuthStateChanged,
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.active) {
    //       UserModel user = snapshot.data as UserModel;
    //       if (user != null) {
    //         // UserModel userModel = UserModel(email: user.uid, uid: user.uid);
    //         return ChangeNotifierProvider<UserModel>(
    //           create: (context) => user,
    //           child: Homepage(),
    //         );
    //       }
    //       return const SignIn();
    //     }
    //     return const Scaffold(
    //       body: Center(
    //         child: CircularProgressIndicator(),
    //       ),
    //     );
    //   },
    // );