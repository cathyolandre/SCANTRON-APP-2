import 'transaction.dart';

class TransactionManager {
  static List<Transaction> transactions = [];

  // Add a new transaction
  static void addTransaction(Transaction transaction) {
    transactions.add(transaction);
  }

  // Get all transactions
  static List<Transaction> getTransactions() {
    return transactions;
  }
}
