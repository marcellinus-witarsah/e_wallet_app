class Transaction {
  final String senderId;
  final String receiverId;
  final String desc;
  final double amount;
  final DateTime timestamp;

  Transaction({
    required this.senderId,
    required this.receiverId,
    required this.desc,
    required this.amount,
    required this.timestamp,
  });
}

class ListTransactions {
  List<Transaction> _transactions = [];

  List<Transaction> get transactions {
    return _transactions;
  }

  void addTransactionToList(Transaction transaction) {
    transactions.add(transaction);
  }
}
