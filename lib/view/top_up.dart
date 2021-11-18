import 'dart:io';

import 'package:e_wallet_app/model/user_model.dart';
import 'package:e_wallet_app/services/auth.dart';
import 'package:e_wallet_app/services/db.dart';
import 'package:e_wallet_app/view/signin_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class TopUp extends StatefulWidget {
  const TopUp({Key? key}) : super(key: key);

  @override
  _TopUpState createState() => _TopUpState();
}

class _TopUpState extends State<TopUp> {
  @override
  Widget build(BuildContext context) {
    final _nominalTopUpController = TextEditingController();
    final _auth = Provider.of<AuthService>(context);
    final _db = Provider.of<DatabaseService>(context);
    final _userModel = Provider.of<UserModel>(context);

    Text txt;
    final nominalTopUp = Container(
      child: TextFormField(
        autofocus: false,
        //using controller for listen and capture email input from user
        controller: _nominalTopUpController,
        //change keyboard for number only
        keyboardType: TextInputType.number,
        //adding validator for email
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(20),
          prefixIcon: Icon(
            Icons.money,
            color: secondaryColor,
          ),
          border: const OutlineInputBorder(),
          labelText: "Amount",
          labelStyle: TextStyle(
            color: secondaryColor,
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Top Up Money"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 40,
            ),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  nominalTopUp,
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
                      child: const Text("Top Up"),
                      onPressed: () async {
                        dynamic msg = await _userModel.topUp(
                            double.parse(_nominalTopUpController.text),
                            "top up");
                        Fluttertoast.showToast(msg: msg);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
