import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_wallet_app/services/firebase_database_service.dart';

class Transaction {
  final String docId;
  final String senderId;
  final String receiverId;
  final String desc;
  final double amount;
  final DateTime timestamp;

  Transaction({
    required this.docId,
    required this.senderId,
    required this.receiverId,
    required this.desc,
    required this.amount,
    required this.timestamp,
  });

  // factory Transaction.fromFirestore(DocumentSnapshot doc){
  //   Map<String, dynamic> data = doc.data();
  //   return Transaction(senderId: , receiverId: receiverId, desc: desc, amount: amount, timestamp: timestamp)
  // }
}

class ListTransactions {
  List<Transaction> _transactions = [];
  FirebaseDatabaseService _db = FirebaseDatabaseService();

  ListTransactions({required db}) : _db = db;

  void set db(FirebaseDatabaseService db) => _db = db;

  List<Transaction> get transactions {
    return _transactions;
  }

  void addTransaction(Transaction transaction) {
    transactions.add(transaction);
  }
}
