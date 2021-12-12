import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currency_formatter/currency_formatter.dart';
import 'package:e_wallet_app/controller/database_controller.dart';
import 'package:e_wallet_app/controller/transaction_controller.dart';
import 'package:e_wallet_app/controller/user_controller.dart';
import 'package:e_wallet_app/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class TransactionHistoryPage extends StatefulWidget {
  @override
  _TransactionHistoryPageState createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  final UserController _userController = Get.put(UserController());
  final DatabaseController _databaseController = Get.put(DatabaseController());
  final TransactionController _transactionController =
      Get.put(TransactionController());
  final _currencyFormatter = CurrencyFormatter();
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

  @override
  Widget build(BuildContext context) {
    Widget listTileForTransactionRecord(uid, data, amount, amountColor) {
      return FutureBuilder<DocumentSnapshot>(
        future: _databaseController.getUserData(uid),
        builder: (context, AsyncSnapshot<DocumentSnapshot> docSnapshot) {
          if (docSnapshot.hasData) {
            Timestamp transactionStamp = data['timestamp'];
            DateTime date = transactionStamp.toDate();
            final day = DateFormat.yMd().format(date);
            // print(transactionStamp.toDate().toString());
            return Card(
              elevation: 5,
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(docSnapshot.data?['first_name']),
                    Text("${day}"),
                  ],
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(data['desc'].toString()),
                    Text(amount, style: TextStyle(color: amountColor)),
                  ],
                ),
              ),
            );
          }
          return costumizedCircularIndicator;
        },
      );
    }

    List<Widget> getAllTransactionWigdet(querySnapshot, uid) {
      List<Widget> listOfTiles = [];
      for (int i = 0; i < querySnapshot.length; i++) {
        Map<String, dynamic> data =
            querySnapshot[i].data()! as Map<String, dynamic>;
        if (data['receiver_id'] == uid || data['sender_id'] == uid) {
          // Format into IDR currency
          String amount =
              _currencyFormatter.format(data['amount'], CurrencyFormatter.idr);

          // color if user top up
          Color amountColor = Colors.green;

          // color if user send money or pay
          if (data['receiver_id'] != uid && data['sender_id'] == uid) {
            amountColor = Colors.red;
            amount = "-" + amount;
          } else {
            amount = "+ " + amount;
          }
          listOfTiles.add(listTileForTransactionRecord(
              data['receiver_id'], data, amount, amountColor));
        }
      }
      return listOfTiles;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('#f7bc3b'),
        title: const Text(
          "Transactions History",
          style: TextStyle(
              fontSize: 21, fontWeight: FontWeight.w800, fontFamily: 'avenir'),
        ),
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder<UserModel?>(
        stream: _userController.user,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return StreamBuilder<QuerySnapshot>(
              stream: _databaseController.getAllTransactionRecords(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> docSnapshot) {
                if (docSnapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (docSnapshot.connectionState == ConnectionState.waiting) {
                  return costumizedCircularIndicator;
                }

                return ListView(
                  children: getAllTransactionWigdet(
                      docSnapshot.data!.docs, snapshot.data?.uid),
                  //     docSnapshot.data!.docs.map((DocumentSnapshot document) {
                  //   Map<String, dynamic> data =
                  //       document.data()! as Map<String, dynamic>;
                  //   // Format into IDR currency
                  //   String amount = _currencyFormatter.format(
                  //       data['amount'], CurrencyFormatter.idr);

                  //   // color if user top up
                  //   Color amountColor = Colors.green;

                  //   // color if user send money or pay
                  //   if (data['receiver_id'] != data['sender_id']) {
                  //     amountColor = Colors.red;
                  //     amount = "- " + amount;
                  //   } else {
                  //     amount = "+ " + amount;
                  //   }
                  //   return listTileForTransactionRecord(
                  //       data['receiver_id'], data, amount, amountColor);
                  // }).toList(),
                );
              },
            );
          }
          return costumizedCircularIndicator;
        },
      ),
    );
  }
}
