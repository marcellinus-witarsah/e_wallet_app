// import 'package:e_wallet_app/services/firebase_database_service.dart';
// import 'package:e_wallet_app/services/firebase_auth_service.dart';
// import 'package:e_wallet_app/view/profile_edit_page.dart';
// import 'package:e_wallet_app/view/qr_page.dart';
// import 'package:e_wallet_app/view/signin_page.dart';
// import 'package:e_wallet_app/view/signup_page.dart';
// import 'package:e_wallet_app/view/top_up.dart';
// import 'package:e_wallet_app/view/transaction_history_page.dart';
// import 'package:e_wallet_app/view/transfer_page.dart';
// import 'package:e_wallet_app/view/verification_page.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// //this page is a stateless as a wrapper for all wighest
// class Homepage extends StatefulWidget {
//   const Homepage({Key? key}) : super(key: key);

//   @override
//   _HomepageState createState() => _HomepageState();
// }

// class _HomepageState extends State<Homepage> {
//   @override
//   Widget build(BuildContext context) {
//     // final _auth = FirebaseAuthService();
//     final _db = Provider.of<FirebaseDatabaseService>(context);
//     final _auth = Provider.of<FirebaseAuthService>(context);

//     Builder buildButton(pageRoute, titlePage, args) {
//       if (args == null) {
//         return Builder(builder: (BuildContext context) {
//           return ElevatedButton(
//             onPressed: () {
//               Navigator.pushNamed(context, pageRoute);
//             },
//             child: Text(titlePage),
//           );
//         });
//       } else {
//         return Builder(builder: (BuildContext context) {
//           return ElevatedButton(
//             onPressed: () {
//               Navigator.pushNamed(context, pageRoute, arguments: args);
//             },
//             child: Text(titlePage),
//           );
//         });
//       }
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Homepage"),
//       ),
//       body: Center(
//           child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           buildButton('/signin', "Sign In", null),
//           buildButton('/signup', "Sign Up", null),
//           buildButton('/transfer', "Transfer", null),
//           buildButton('/topup', "Top Up", {'verified': false}),
//           buildButton('/transaction_history', "Transaction History", null),
//           buildButton('/profile', "Profile Edit", null),
//           buildButton('/qr', "QR Page", null),
//           // buildButton(PinCodePage(), "Pin Code Page", null),
//           Container(
//             width: double.infinity,
//             height: 50,
//             child: RaisedButton(
//               color: Colors.blue,
//               textColor: Colors.white,
//               splashColor: Colors.blueGrey,
//               child: const Text("Sign Out"),
//               onPressed: () {
//                 print(_auth.SignOutAccount());
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => SignIn(),
//                     ));
//               },
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//         ],
//       )),
//     );
//   }
// }
