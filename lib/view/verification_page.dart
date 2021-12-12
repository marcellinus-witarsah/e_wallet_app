// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:e_wallet_app/model/user_model.dart';
// import 'package:e_wallet_app/services/firebase_auth_service.dart';
// import 'package:e_wallet_app/services/firebase_database_service.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:provider/provider.dart';

// enum PinCodeUsage {
//   verification,
//   create,
// }

// class PinCodePage extends StatefulWidget {
//   const PinCodePage({Key? key}) : super(key: key);

//   @override
//   _PinCodePageState createState() => _PinCodePageState();
// }

// class _PinCodePageState extends State<PinCodePage> {
//   @override
//   Widget build(BuildContext context) {
//     final FirebaseAuthService _auth = Provider.of<FirebaseAuthService>(context);
//     final FirebaseDatabaseService _db =
//         Provider.of<FirebaseDatabaseService>(context);
//     TextEditingController textEditingController = TextEditingController();
//     final arguments = ModalRoute.of(context)!.settings.arguments as Map;

//     Widget buildExitButton() {
//       return Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.all(10),
//             child: MaterialButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               height: 50.0,
//               minWidth: 50.0,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(50.0),
//               ),
//               child: const Icon(
//                 Icons.clear,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//         ],
//       );
//     }

//     return Scaffold(
//       body: StreamBuilder<UserModel?>(
//           stream: _auth.user,
//           builder: (context, snapshot) {
//             final user = snapshot.data;
//             return Container(
//               child: SafeArea(
//                 child: Column(
//                   children: [
//                     Expanded(
//                       child: FutureBuilder<DocumentSnapshot?>(
//                         future: _db.getUserData(user?.uid),
//                         builder: (BuildContext context,
//                             AsyncSnapshot<DocumentSnapshot?> docSnapshot) {
//                           return Container(
//                             alignment: const Alignment(0, 0.5),
//                             padding:
//                                 const EdgeInsets.symmetric(horizontal: 16.00),
//                             child: Column(
//                               children: <Widget>[
//                                 buildExitButton(),
//                                 const Text(
//                                   "Security PIN",
//                                   style: TextStyle(
//                                     fontSize: 21,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   height: 30,
//                                 ),
//                                 PinCodeTextField(
//                                   appContext: context,
//                                   pastedTextStyle: TextStyle(
//                                     color: Colors.green.shade600,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                   length: 6,
//                                   obscureText: true,
//                                   obscuringCharacter: '*',
//                                   animationType: AnimationType.fade,
//                                   pinTheme: PinTheme(
//                                     shape: PinCodeFieldShape.box,
//                                     borderRadius: BorderRadius.circular(10),
//                                     fieldHeight:
//                                         MediaQuery.of(context).size.width / 8.0,
//                                     fieldWidth:
//                                         MediaQuery.of(context).size.width / 8.0,
//                                   ),
//                                   autoFocus: true,
//                                   textStyle: const TextStyle(
//                                       fontSize: 20, height: 1.6),
//                                   // enableActiveFill: true,
//                                   controller: textEditingController,
//                                   keyboardType: TextInputType.number,
//                                   onCompleted: (value) async {
//                                     if (arguments['usage'] ==
//                                         PinCodeUsage.create) {
//                                       await _db.updateUserCollection(
//                                           snapshot.data!.uid,
//                                           {'pin_code': value});
//                                       Navigator.popAndPushNamed(
//                                         context,
//                                         arguments['destination'],
//                                       );
//                                     } else if (arguments['usage'] ==
//                                         PinCodeUsage.verification) {
//                                       if (value ==
//                                           docSnapshot.data!['pin_code']) {
//                                         Fluttertoast.showToast(
//                                             msg: "pin is correct");
//                                         Navigator.popAndPushNamed(
//                                             context, arguments['destination'],
//                                             arguments: {
//                                               'is_verified': true,
//                                               'transaction_type':
//                                                   arguments['transaction_type'],
//                                               'data': arguments['data'],
//                                             });
//                                       } else {
//                                         Fluttertoast.showToast(
//                                             msg: "pin is incorrect");
//                                       }
//                                     }
//                                   },
//                                   onChanged: (String value) {
//                                     print(value);
//                                   },
//                                 ),
//                                 const SizedBox(
//                                   height: 30.0,
//                                 ),
//                                 // buildNumberPad(),
//                               ],
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }),
//     );
//   }
// }
