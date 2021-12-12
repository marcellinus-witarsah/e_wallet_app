// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:e_wallet_app/model/user_model.dart';
// import 'package:e_wallet_app/services/firebase_auth_service.dart';
// import 'package:e_wallet_app/services/firebase_database_service.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// //this page is a stateless as a wrapper for all wighest
// class TransactionHistory extends StatefulWidget {
//   const TransactionHistory({Key? key}) : super(key: key);

//   @override
//   _TransactionHistoryState createState() => _TransactionHistoryState();
// }

// class _TransactionHistoryState extends State<TransactionHistory> {
//   @override
//   Widget build(BuildContext context) {
//     final _db = Provider.of<FirebaseDatabaseService>(context);
//     final _auth = Provider.of<FirebaseAuthService>(context);

//     return StreamBuilder<UserModel?>(
//         stream: _auth.user,
//         builder: (context, snapshot) {
//           return Scaffold(
//             appBar: AppBar(
//               title: const Text("Homepage"),
//             ),
//             body: Center(
//               child: StreamBuilder<QuerySnapshot>(
//                 stream: _db.transactions
//                     .where('sender_id', isEqualTo: snapshot.data!.uid)
//                     .snapshots(),
//                 builder: (context, snapshotData) {
//                   if (snapshotData.hasData) {
//                     return ListView.builder(
//                         itemCount: snapshotData.data!.docs.length,
//                         itemBuilder: (context, index) {
//                           final data = snapshotData.data!.docs[index];
//                           return Column(
//                             children: <Widget>[
//                               // Text("${data['timestamp']}, ${data['sender_id']}"),
//                               Text("${data.id} = ${data['amount']}"),
//                             ],
//                           );
//                         });
//                   } else {
//                     return Text("error");
//                   }
//                 },
//               ),
//             ),
//           );
//         });
//   }
// }
