import 'package:e_wallet_app/controller/database_controller.dart';
import 'package:e_wallet_app/controller/user_controller.dart';
import 'package:e_wallet_app/main.dart';
import 'package:e_wallet_app/models/user_model.dart';
import 'package:e_wallet_app/ui/home_screen_with_sidebar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// To check if user already sign in or not
class Wrapper extends StatefulWidget {
  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final UserController _userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModel?>(
      stream: _userController.user,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data?.uid);
          return homeWithSidebar();
        }
        return MyHomePage();
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