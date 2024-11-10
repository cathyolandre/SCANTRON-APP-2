import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Add this import for StockProvider
import 'models/stock_provider.dart'; // Import the StockProvider

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  InventoryPageState createState() => InventoryPageState();
}

class InventoryPageState extends State<InventoryPage> {
  final TextEditingController _stockController = TextEditingController();
  String _currentInput = ''; // Store the current input to be directly assigned to stock

  @override
  void initState() {
    super.initState();
    // Initialize the text field with the current stock value from StockProvider
    int currentStock = Provider.of<StockProvider>(context, listen: false).stock;
    _currentInput = currentStock.toString();
    _stockController.text = _currentInput;
  }

  @override
  void dispose() {
    _stockController.dispose();
    super.dispose();
  }

  // Method to directly update the stock to the value entered in the input
  void _updateStockCount() {
    setState(() {
      final newValue = int.tryParse(_currentInput) ?? 100; // Default to 100 if invalid input
      final newStockCount = newValue.clamp(0, 200); // Limits stock between 0 and 200
      Provider.of<StockProvider>(context, listen: false).restock(newStockCount);
      _stockController.text = newStockCount.toString(); // Update with valid count
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get the current stock value from StockProvider
    int stock = Provider.of<StockProvider>(context).stock;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory Management'),
        centerTitle: true,
      ),
      body: Center( // Center the content in the body
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Ensure everything is centered
            crossAxisAlignment: CrossAxisAlignment.center, // Align children centrally
            children: [
              // Display current stock count
              Text(
                'Current Stock: $stock',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Text Field to display the input value
              SizedBox(
                width: 150,
                child: TextField(
                  controller: _stockController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Stock',
                  ),
                  onChanged: (value) {
                    _currentInput = value; // Update the input as the user types
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Single Enter button for updating stock
              ElevatedButton(
                onPressed: _updateStockCount,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  backgroundColor: Colors.blue, // Button background color
                ),
                child: const Text(
                  'Enter',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
