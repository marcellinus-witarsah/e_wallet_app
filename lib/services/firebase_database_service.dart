import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_wallet_app/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirebaseDatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  void addDataToDb(collectionName, data, uid) {
    CollectionReference dataCollection = _db.collection(collectionName);
    switch (collectionName) {
      case dbUsersCollection:
        dataCollection.doc(uid).set(data);
        break;
      case dbTransactionsCollection:
        dataCollection.doc().set(data);
        break;
    }
  }

  Future getUserIdByEmail(email) async {
    try {
      dynamic res = await _db
          .collection('users')
          .where('email', isEqualTo: email)
          .get()
          .then((QuerySnapshot querySnapshot) {
        return querySnapshot.docs[0].id;
      });
      return res;
    } catch (e) {
      return "Error Finding User";
    }
  }

  Future addTransactions(data) {
    return transactions
        .add({
          'sender_id': data['senderId'],
          'receiver_id': data['receiverId'],
          'desc': data['desc'],
          'amount': data['amount'],
          'timestamp': DateTime.now(),
        })
        .then((value) => print("Transaction data added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future updateUserCollection(uid, data) {
    return users.doc(uid).update(data);
  }

  Future getSpecificDataField(collectionName, id, fieldName) {
    return _db
        .collection(collectionName)
        .doc(id)
        .get()
        .then((snap) => (snap[fieldName]));
  }

  Future<DocumentSnapshot?> getUserData(uid) {
    return users.doc(uid).get();
  }

  CollectionReference get transactions {
    return _db.collection(dbTransactionsCollection);
  }

  CollectionReference get users {
    return _db.collection(dbUsersCollection);
  }

  Stream<QuerySnapshot> getUserDataById(uid) {
    return transactions
        .where('receiver_id', isEqualTo: uid)
        .orderBy("timestamp")
        .snapshots();
  }
}
