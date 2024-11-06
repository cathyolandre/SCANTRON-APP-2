import 'package:flutter/material.dart';
import 'package:orderapp/view_report_page.dart';

class StockProvider extends ChangeNotifier {
  int _stock = 200;
  final List<Report> _transactions = []; // Add a list of transactions

  int get stock => _stock;

  // Add a method to add a new transaction to the list
  List<Report> get transactions => _transactions;

  void restock(int newStock) {
    _stock = newStock;
    notifyListeners();
  }

  // Add a new transaction
  void addTransaction(int orderQuantity, double totalPrice) {
    _transactions.insert(
      0, // Add the new transaction at the top
      Report(
        orderQuantity: orderQuantity,
        totalPrice: totalPrice,
        date: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
