import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_wallet_app/constants.dart';
import 'package:e_wallet_app/controller/database_controller.dart';
import 'package:e_wallet_app/models/transaction_model.dart';
import 'package:e_wallet_app/view/transaction_history_page.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController {
  // uising database controller for interacting with DatabaseController class by using its function
  // final = mean that this is a final and "_" mean is a private variable
  final DatabaseController _databaseController = Get.put(DatabaseController());

  Future topUp(amount, desc, uid) async {
    //for update balance in users collections
    if (amount < 10000.0) {
      return "Transaction must be at least 10000";
    } else {
      try {
        // update user's balancer
        print(uid);
        dynamic curBalance = await _databaseController.getSpecificDataField(
            dbUsersCollection, uid, 'balance');
        print(curBalance);
        dynamic newBalance = curBalance + amount;
        print(newBalance);

        _databaseController.updateUserCollection(uid, {'balance': newBalance});

        _databaseController.addTransactions({
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

  // transfer money from user to other user
  Future transfer(receiverEmail, amount, desc, uid) async {
    //for update balance in users collections
    dynamic curBalance = await _databaseController.getSpecificDataField(
        dbUsersCollection, uid, 'balance');
    if (curBalance < amount) {
      return "You don't have enough money";
    } else {
      print("cur balance = ${curBalance}");
      try {
        // update sender's balance
        dynamic newBalance = curBalance - amount;
        _databaseController.updateUserCollection(uid, {'balance': newBalance});
        print(newBalance);

        // update receiver's balance
        dynamic receiverUid =
            await _databaseController.getUserIdByEmail(receiverEmail);
        dynamic receiverCurBalance = await _databaseController
            .getSpecificDataField(dbUsersCollection, receiverUid, 'balance');
        print(receiverUid);
        print(receiverCurBalance);
        dynamic receiverNewBalance = receiverCurBalance + amount;
        print(receiverNewBalance);
        _databaseController
            .updateUserCollection(receiverUid, {'balance': receiverNewBalance});

        // add data transactions to firebase
        _databaseController.addTransactions({
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

  // Get 1 document user transactions
  Future<TransactionRecord> getTransactionRecord(DocumentSnapshot doc) async {
    return TransactionRecord.fromFirestore(doc);
  }

  // Get lists of documents transactions relating to user
  // Future<List<TransactionRecord>> getAllTransactionRecordsByUid(uid) {
  //   List<TransactionRecord> listTransactionRecords;
  //   QuerySnapshot querySnapshot = _databaseController.transactions
  //       .where('sender_id', isEqualTo: uid)
  //       .get();

  //   querySnapshot.forEach((doc) =>
  //       listTransactionRecords.add(TransactionRecord.fromFirestore(doc)));
  //   // .((list) =>
  //   //     list.docs.forEach((doc) => TransactionRecord.fromFirestore(doc)));
  // }
  Stream<List<TransactionRecord>> getAllTransactionRecordsByUid(uid) {
    Stream<QuerySnapshot> streamQuerySnapshot = _databaseController.transactions
        .where('sender_id', isEqualTo: uid)
        .snapshots();

    return streamQuerySnapshot.map((querySnapshot) => querySnapshot.docs
        .map((doc) => TransactionRecord.fromFirestore(doc))
        .toList());
  }
}
