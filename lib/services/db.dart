import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_wallet_app/adapter/adapter.dart';
import 'package:e_wallet_app/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DatabaseService {
  final FirebaseFirestore _db;

  DatabaseService(this._db);

  void addDataToDb(collectionName, data, uid) {
    CollectionReference dataCollection = _db.collection(collectionName);
    switch (collectionName) {
      case Constants.dbUsersCollection:
        dataCollection.doc(uid).set(data);
        break;
      case Constants.dbTransactionsCollection:
        dataCollection.doc().set(data);
        break;
    }
  }

  // Future getDataFromDb(collectionName) async {
  //   return Adapter.getDataFromDb(_db.collection(collectionName));
  // }

  Future getUserByEmail(email) async {
    try {
      dynamic res = await _db
          .collection('users')
          .where('email', isEqualTo: email)
          .get()
          .then((value) => value);
      print(res);
    } catch (e) {
      return "Error Finding User";
    }
    // print("masuk");
  }

  Stream<QuerySnapshot> get transactions {
    final CollectionReference transactionsCollection =
        _db.collection(Constants.dbTransactionsCollection);
    return transactionsCollection.snapshots();
  }

  CollectionReference get users {
    final CollectionReference usersCollection =
        _db.collection(Constants.dbUsersCollection);
    return usersCollection;
  }
}
