import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_wallet_app/constants.dart';
import 'package:e_wallet_app/development/queryresult.dart';
import 'package:e_wallet_app/model/user_model.dart';
import 'package:e_wallet_app/services/auth.dart';
import 'package:e_wallet_app/services/db.dart';
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
    final _auth = AuthService(FirebaseAuth.instance);
    final _db = DatabaseService(FirebaseFirestore.instance);
    final _userModel = Provider.of<UserModel>(context);

    print("Halo ${_userModel.uid}");

    Builder buildButton(page, titlePage) {
      return Builder(builder: (BuildContext context) {
        return ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                          create: (_) => _userModel,
                          child: page,
                        )));
          },
          child: Text(titlePage),
        );
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Homepage"),
      ),
      body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildButton(SignIn(), "Sign In"),
              buildButton(SignUp(), "Sign Up"),
              buildButton(Transfer(), "Transfer"),
              buildButton(TopUp(), "Top Up"),
              buildButton(TransactionHistory(), "Transaction History"),
              buildButton(QueryResult(), "Query Result"),
              Text("Homepage"),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: 50,
                child: RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  splashColor: Colors.blueGrey,
                  child: const Text("Sign Out"),
                  onPressed: () {
                    print(_auth.SignOutAccount());
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignIn(),
                        ));
                  },
                ),
              ),
            ],
          )),
    );
  }
}
