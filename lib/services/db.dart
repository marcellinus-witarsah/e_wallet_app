import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_wallet_app/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  void addDataToDb(collectionName, data) {
    CollectionReference dataCollection = _db.collection(collectionName);

    switch (collectionName) {
      case Constants.dbUserCollection:
        dataCollection.doc(data["uid"]).set(data);
        break;
    }
  }

  Future getDataFromDb(collectionName) {
    CollectionReference dataCollection = _db.collection(collectionName);
    return dataCollection.get();
  }
}
