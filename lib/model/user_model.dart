import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:e_wallet_app/constants.dart';
import 'package:e_wallet_app/services/firebase_database_service.dart';

class UserModel {
  late String _uid;
  late String _firstName;
  late String _lastName;
  late String _email;
  late String _phoneNumber;

  final FirebaseAuth auth = FirebaseAuth.instance;
  final _db = FirebaseDatabaseService();

  UserModel(uid) {
    _uid = uid;
    // setUserData();
  }

  String get uid => _uid;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get email => _email;
  String get phoneNumber => _phoneNumber;

  // void setFirstName(String firstName) {
  //   _firstName = firstName;
  // }

  // void setLastName(String lastName) {
  //   _lastName = lastName;
  // }

  // void setEmail(String email) {
  //   _email = email;
  // }

  // void setPhoneNumber(String phoneNumber) {
  //   _phoneNumber = phoneNumber;
  // }

  // void setUserData() async {
  //   dynamic userData = await _db.getUserData(_uid);
  //   setFirstName(userData['first_name']);
  //   setLastName(userData['last_name']);
  //   setEmail(userData['email']);
  //   setPhoneNumber(userData['phone_number']);
  // }

  Future topUp(amount, desc) async {
    //for update balance in users collections
    if (amount < 10000.0) {
      return "Transaction must be at least 10000";
    } else {
      try {
        // update user's balancer
        print(uid);
        dynamic curBalance = await _db.getSpecificDataField(
            Constants.dbUsersCollection, uid, 'balance');
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
        return "Top Up Successful";
      } catch (e) {
        return "Top Up Error, Please Try Again";
      }
    }
  }

  // transfer money

  Future transfer(receiverEmail, amount, desc) async {
    //for update balance in users collections
    dynamic curBalance = await _db.getSpecificDataField(
        Constants.dbUsersCollection, uid, 'balance');
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
            Constants.dbUsersCollection, receiverUid, 'balance');
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
        return "Transaction Successful";
      } catch (e) {
        return "Transaction Up Error, Please Try Again $e";
      }
    }
  }
}
