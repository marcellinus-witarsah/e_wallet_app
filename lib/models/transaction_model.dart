import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_wallet_app/services/firebase_database_service.dart';

class TransactionRecord {
  final String docId;
  final String senderId;
  final String receiverId;
  final String desc;
  final double amount;
  final DateTime timestamp;

  TransactionRecord({
    required this.docId,
    required this.senderId,
    required this.receiverId,
    required this.desc,
    required this.amount,
    required this.timestamp,
  });

  factory TransactionRecord.fromFirestore(DocumentSnapshot doc) {
    Map map = doc.data() as Map;
    return TransactionRecord(
        docId: doc.id,
        senderId: map['sender_id'],
        receiverId: map['receiver_id'],
        desc: map['desc'],
        amount: map['amount'],
        timestamp: map['timestamp']);
  }
  // factory UserModel.fromMap(Map<String, dynamic> map) {
  //   return UserModel(uid: map['uid']);
  // }
}

// class Transactions {
//   List<Transaction> _transactions = [];
//   FirebaseDatabaseService _db = FirebaseDatabaseService();

//   Transactions({required db}) : _db = db;

//   void set db(FirebaseDatabaseService db) => _db = db;

//   List<Transaction> get transactions {
//     return _transactions;
//   }

//   void addTransaction(Transaction transaction) {
//     transactions.add(transaction);
//   }
// }
