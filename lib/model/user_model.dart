import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:e_wallet_app/constants.dart';
import 'package:e_wallet_app/services/db.dart';

class UserModel with ChangeNotifier {
  final String _uid;

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  UserModel(this._uid);

  String get getUid {
    return _uid;
  }

  //get balance of the user wallet
  Future getBalance() {
    return db
        .collection(Constants.dbUsersCollection)
        .doc(_uid)
        .get()
        .then((snap) => (snap['balance']));
  }

  Future topUp(amount, desc) async {
    //for update balance in users collections
    if (amount < 10000.0) {
      return "Transaction must be at least 10000";
    } else {
      try {
        CollectionReference users = db.collection(Constants.dbUsersCollection);
        dynamic curBalance = await getBalance();
        print(curBalance);
        dynamic newBalance = curBalance + amount;
        print(newBalance);
        CollectionReference transactions =
            db.collection(Constants.dbTransactionsCollection);

        users.doc(_uid).update({'balance': newBalance});
        
        transactions.doc().set({
          'sender_id': _uid,
          'receiver_id': _uid,
          'desc': desc,
          'amount': amount,
          'date': DateTime.now().toString(),
        });
        return "Top Up Successful";
      } catch (e) {
        return "Top Up Error, Please Try Again";
      }
    }
  }

  Future transfer(senderId, amount, desc) async {
    //for update balance in users collections
    dynamic curBalance = await getBalance();
    if (curBalance < amount) {
      return "You don't have enaough money";
    } else {
      CollectionReference users = db.collection(Constants.dbUsersCollection);
      dynamic curBalance = await getBalance();
      dynamic newBalance = curBalance - amount;
      
      CollectionReference transactions =
          db.collection(Constants.dbTransactionsCollection);
      users.doc(_uid).update({'balance': newBalance});
      transactions.doc().set({
        'sender_id': _uid,
        'receiver_id': senderId,
        'desc': desc,
        'amount': amount,
        'date': DateTime.now().toString(),
      });
    }
  }
}
