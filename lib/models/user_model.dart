import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:e_wallet_app/constants.dart';
import 'package:e_wallet_app/services/firebase_database_service.dart';

class UserModel {
  final String uid;

  final FirebaseAuth auth = FirebaseAuth.instance;
  final _db = FirebaseDatabaseService();

  UserModel({required this.uid});

  // return new instance with user model information to prevent manipulation
  // unresponsible user can't tamper user model data because they dont have
  // any reference to that object.
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(uid: map['uid']);
  }

  Future topUp(amount, desc) async {
    //for update balance in users collections
    if (amount < 10000.0) {
      return "Transaction must be at least 10000";
    } else {
      try {
        // update user's balancer
        print(uid);
        dynamic curBalance =
            await _db.getSpecificDataField(dbUsersCollection, uid, 'balance');
        print(curBalance);
        dynamic newBalance = curBalance + amount;
        print(newBalance);

        _db.updateUserCollection(uid, {'balance': newBalance});

        _db.addTransactions({
          "senderId": uid,
          "receiverId": uid,
          "amount": amount,
          "desc": desc,
        });
        return successful;
      } catch (e) {
        return error;
      }
    }
  }

  // transfer money

  Future transfer(receiverEmail, amount, desc) async {
    //for update balance in users collections
    dynamic curBalance =
        await _db.getSpecificDataField(dbUsersCollection, uid, 'balance');
    if (curBalance < amount) {
      return "You don't have enough money";
    } else {
      print("cur balance = ${curBalance}");
      try {
        // update sender's balance
        dynamic newBalance = curBalance - amount;
        _db.updateUserCollection(uid, {'balance': newBalance});
        print(newBalance);

        // update receiver's balance
        dynamic receiverUid = await _db.getUserIdByEmail(receiverEmail);
        dynamic receiverCurBalance = await _db.getSpecificDataField(
            dbUsersCollection, receiverUid, 'balance');
        print(receiverUid);
        print(receiverCurBalance);
        dynamic receiverNewBalance = receiverCurBalance + amount;
        print(receiverNewBalance);
        _db.updateUserCollection(receiverUid, {'balance': receiverNewBalance});

        // add data transactions to firebase
        _db.addTransactions({
          "senderId": uid,
          "receiverId": receiverUid,
          "amount": amount,
          "desc": desc,
        });
        return successful;
      } catch (e) {
        return error;
      }
    }
  }
}
