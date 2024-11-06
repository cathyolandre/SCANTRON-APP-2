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

  // Method to handle numpad button press
  void _onNumpadButtonPressed(String value) {
    setState(() {
      _currentInput = _currentInput + value; // Append the pressed value to the current input
      _stockController.text = _currentInput; // Show the input in the text field
    });
  }

  // Method to handle delete
  void _onDeletePressed() {
    setState(() {
      if (_currentInput.isNotEmpty) {
        _currentInput = _currentInput.substring(0, _currentInput.length - 1); // Remove the last digit
        _stockController.text = _currentInput;
      }
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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

            // Numpad for stock input
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.5,
              ),
              itemCount: 12,
              itemBuilder: (context, index) {
                String buttonText;
                if (index < 9) {
                  buttonText = (index + 1).toString(); // Number 1-9
                } else if (index == 9) {
                  buttonText = '0'; // Number 0
                } else if (index == 10) {
                  buttonText = 'Del'; // Delete button
                } else {
                  buttonText = 'Enter'; // Enter button
                }

                return GestureDetector(
                  onTap: () {
                    if (buttonText == 'Del') {
                      _onDeletePressed(); // Remove last digit
                    } else if (buttonText == 'Enter') {
                      _updateStockCount(); // Update stock with the entered value
                    } else {
                      _onNumpadButtonPressed(buttonText); // Append the number to the input
                    }
                  },
                  child: Card(
                    margin: const EdgeInsets.all(5),
                    elevation: 5,
                    color: const Color.fromARGB(255, 0, 0, 0),
                    child: Center(
                      child: Text(
                        buttonText,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),

          
          ],
        ),
      ),
    );
  }
}
