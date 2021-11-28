import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_wallet_app/constants.dart';
import 'package:e_wallet_app/model/user_model.dart';
import 'package:e_wallet_app/services/auth_service.dart';
import 'package:e_wallet_app/services/firebase_database_service.dart';
import 'package:e_wallet_app/services/firebase_auth_service.dart';
import 'package:e_wallet_app/view/profile_edit_page.dart';
import 'package:e_wallet_app/view/signin_page.dart';
import 'package:e_wallet_app/view/signup_page.dart';
import 'package:e_wallet_app/view/top_up.dart';
import 'package:e_wallet_app/view/transaction_history_page.dart';
import 'package:e_wallet_app/view/transfer_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//this page is a stateless as a wrapper for all wighest
class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    // final _auth = FirebaseAuthService();
    final _db = Provider.of<FirebaseDatabaseService>(context);
    final _auth = Provider.of<FirebaseAuthService>(context);

    Builder buildButton(page, titlePage) {
      return Builder(builder: (BuildContext context) {
        return ElevatedButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => page));
          },
          child: Text(titlePage),
        );
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Homepage"),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildButton(SignIn(), "Sign In"),
          buildButton(SignUp(), "Sign Up"),
          buildButton(Transfer(), "Transfer"),
          buildButton(TopUp(), "Top Up"),
          buildButton(TransactionHistory(), "Transaction History"),
          buildButton(ProfilePage(), "Profile Edit"),
          const SizedBox(
            height: 20,
          ),
        ],
      )),
    );
  }
}
