import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_wallet_app/constants.dart';
import 'package:e_wallet_app/development/queryresult.dart';
import 'package:e_wallet_app/model/user_model.dart';
import 'package:e_wallet_app/services/auth.dart';
import 'package:e_wallet_app/services/db.dart';
import 'package:e_wallet_app/view/signin_page.dart';
import 'package:e_wallet_app/view/signup_page.dart';
import 'package:e_wallet_app/view/top_up.dart';
import 'package:e_wallet_app/view/transfer_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//this page is a stateless as a wrapper for all wighest
class TransactionHistory extends StatefulWidget {
  const TransactionHistory({Key? key}) : super(key: key);

  @override
  _TransactionHistoryState createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  @override
  Widget build(BuildContext context) {
    final _auth = AuthService(FirebaseAuth.instance);
    final _db = DatabaseService(FirebaseFirestore.instance);
    final _userModel = Provider.of<UserModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Homepage"),
      ),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: _db.transactions.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final data = snapshot.data!.docs[index];
                    return Row(
                      children: <Widget>[
                        Text(
                            "${data['timestamp']}, ${data['sender_id']}, ${data['receiver_id']}, ${data['amount']}"),
                      ],
                    );
                  });
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
