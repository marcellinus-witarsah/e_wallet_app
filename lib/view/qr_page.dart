// import 'dart:io';

// import 'package:e_wallet_app/model/user_model.dart';
// import 'package:e_wallet_app/services/firebase_auth_service.dart';
// import 'package:e_wallet_app/view/qr_scanner_page.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
// import 'package:qr_flutter/qr_flutter.dart';

// class QRPage extends StatefulWidget {
//   const QRPage({Key? key}) : super(key: key);

//   @override
//   _QRPageState createState() => _QRPageState();
// }

// class _QRPageState extends State<QRPage> {
//   @override
//   Widget build(BuildContext context) {
//     final FirebaseAuthService _auth = Provider.of<FirebaseAuthService>(context);

//     return Scaffold(
//       body: StreamBuilder<UserModel?>(
//         stream: _auth.user,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.active) {
//             return Center(
//               child: Container(
//                 padding: const EdgeInsets.all(24),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     QrImage(data: snapshot.data!.uid),
//                     const SizedBox(
//                       height: 40,
//                     ),
//                     ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => QRScannerPage()));
//                         },
//                         child: const Text("Scan QR code")),
//                   ],
//                 ),
//               ),
//             );
//           } else {
//             return const CircularProgressIndicator();
//           }
//         },
//       ),
//     );
//   }
// }
