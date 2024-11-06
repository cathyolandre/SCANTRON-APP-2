class Transaction {
  final String customerName;
  final int quantity;
  final DateTime timestamp;

  Transaction({
    required this.customerName,
    required this.quantity,
    required this.timestamp,
  });
}
