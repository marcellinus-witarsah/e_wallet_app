import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_wallet_app/constants.dart';
import 'package:e_wallet_app/services/db.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class QueryResult extends StatelessWidget {
  String collectionName = Constants.dbUsersCollection;

  // QueryResult({required this.collectionName});

  @override
  Widget build(BuildContext context) {
    final _db = Provider.of<DatabaseService>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text("Query Results"),
        ),
        body: Column(
          children: <Widget>[
            ElevatedButton(
                onPressed: () {
                  // _db.getDataFromDb(collectionName);
                },
                child: Text("Click Me"))
          ],
        ));
  }
}
