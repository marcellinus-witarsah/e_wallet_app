import 'package:flutter/material.dart';

//collction name in database
const dbUsersCollection = 'users';
const dbTransactionsCollection = 'transactions';
const dbWalletCollection = 'wallet';
const successful = "succesful";
const error = "error";

final Widget costumizedCircularIndicator = Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const <Widget>[
      CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Color(0xffffac30)),
      )
    ],
  ),
);
