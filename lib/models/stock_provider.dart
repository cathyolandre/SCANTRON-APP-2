import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:orderapp/view_report_page.dart';

class StockProvider extends ChangeNotifier {
  int _stock = 200;
  final List<Report> _transactions = [];

  int get stock => _stock;
  List<Report> get transactions => _transactions;

  StockProvider() {
    _loadTransactionsFromFirestore();
  }

  // Fetch transactions from Firestore and handle errors
  Future<void> _loadTransactionsFromFirestore() async {
    try {
      final transactionsSnapshot = await FirebaseFirestore.instance
          .collection('transactions')
          .get();
      for (var doc in transactionsSnapshot.docs) {
        _transactions.add(
          Report(
            orderQuantity: doc['orderQuantity'],
            totalPrice: doc['totalPrice'],
            date: (doc['date'] as Timestamp).toDate(),
            studentId: doc['studentId'], // Add studentId from Firestore
          ),
        );
      }
      notifyListeners();
    } catch (e) {
      print("Error loading transactions: $e");
    }
  }

  // Restock method to update the stock count
  void restock(int newStock) {
    _stock = newStock;
    notifyListeners();
  }

  // Add a new transaction to both local list and Firestore, including student ID
  void addTransaction(int orderQuantity, double totalPrice, String studentId) async {
    final report = Report(
      orderQuantity: orderQuantity,
      totalPrice: totalPrice,
      date: DateTime.now(),
      studentId: studentId, // Include studentId in the transaction
    );

    // Add the new report to the local list
    _transactions.insert(0, report);

    try {
      // Add the new transaction to Firestore
      await FirebaseFirestore.instance.collection('transactions').add({
        'orderQuantity': orderQuantity,
        'totalPrice': totalPrice,
        'date': Timestamp.fromDate(report.date),
        'studentId': studentId, // Add studentId to the Firestore document
      });
      notifyListeners();
    } catch (e) {
      print("Error adding transaction: $e");
    }
  }
}
