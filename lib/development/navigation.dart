// this page is for development only
import 'package:e_wallet_app/development/queryresult.dart';
import 'package:e_wallet_app/view/signin_page.dart';
import 'package:e_wallet_app/view/signup_page.dart';
import 'package:e_wallet_app/view/top_up.dart';
import 'package:e_wallet_app/view/transfer_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Navigation extends StatelessWidget {
  const Navigation({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              buildButton(SignIn(), "Sign In"),
              buildButton(SignUp(), "Sign Up"),
              buildButton(Transfer(), "Transfer"),
              buildButton(TopUp(), "Top Up"),
              buildButton(QueryResult(), "Query Result"),
            ],
          ),
        ),
      ),
    );
  }
}
