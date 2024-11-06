import 'package:flutter/material.dart';

class StockProvider with ChangeNotifier {
  int _stock = 100; // Initial stock value

  // Getter for the stock
  int get stock => _stock;

  // Method to update stock
  void restock(int newStock) {
    // Make sure stock is within the allowed range (0 to 200)
    if (newStock >= 0 && newStock <= 200) {
      _stock = newStock;
      notifyListeners(); // Notify listeners to update UI
    }
  }
}
