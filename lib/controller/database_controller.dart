import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_wallet_app/constants.dart';
import 'package:get/get.dart';

class DatabaseController extends GetxController {
  // create a Firebase Firestore instance for interacting with Firebase Firestore services
  // final = mean that this is a final and "_" mean is a private variable
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // Adding new data to database
  void addDataToDb(collectionName, data, uid) {
    switch (collectionName) {
      case dbUsersCollection:
        users.doc(uid).set(data);
        break;
      case dbTransactionsCollection:
        transactions.doc().set(data);
        break;
    }
  }

  // Getting other user uid by email for transaction
  Future getUserIdByEmail(email) async {
    try {
      dynamic res = await users
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

  // Adding transactions to the transactions collection inside firestore
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

  // Update user collection
  Future updateUserCollection(uid, data) {
    return users.doc(uid).update(data);
  }

  Future getSpecificDataField(collectionName, id, fieldName) {
    return _firebaseFirestore
        .collection(collectionName)
        .doc(id)
        .get()
        .then((snap) => (snap[fieldName]));
  }

  Future<DocumentSnapshot> getUserData(uid) {
    return users.doc(uid).get();
  }

  Stream<QuerySnapshot> getAllTransactionRecordsById(uid) {
    return transactions
        .where('sender_id', isEqualTo: uid)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot> getAllTransactionRecords() {
    return transactions.orderBy('timestamp', descending: true).snapshots();
  }

  // return trabnsactions collection
  CollectionReference get transactions {
    return _firebaseFirestore.collection(dbTransactionsCollection);
  }

  // return users collection
  CollectionReference get users {
    return _firebaseFirestore.collection(dbUsersCollection);
  }
}
