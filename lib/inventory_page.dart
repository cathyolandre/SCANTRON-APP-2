import 'package:flutter/material.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  int _stockCount = 100; // Example initial stock count
  final TextEditingController _stockController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize the text field with the current stock value
    _stockController.text = _stockCount.toString();
  }

  @override
  void dispose() {
    _stockController.dispose();
    super.dispose();
  }

  // Method to update the stock count from the text field
  void _updateStockCount() {
    setState(() {
      final newValue = int.tryParse(_stockController.text) ?? _stockCount;
      _stockCount = newValue.clamp(0, 200); // Limits stock between 0 and 200
      _stockController.text = _stockCount.toString(); // Update with valid count
    });
  }

  @override
  Widget build(BuildContext context) {
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
              'Current Stock: $_stockCount',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Text field for inputting stock value directly
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Decrement button
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (_stockCount > 0) _stockCount--;
                      _stockController.text = _stockCount.toString();
                    });
                  },
                  icon: const Icon(Icons.remove),
                ),

                // Text Field
                SizedBox(
                  width: 100,
                  child: TextField(
                    controller: _stockController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Stock',
                    ),
                    onSubmitted: (_) => _updateStockCount(),
                  ),
                ),

                // Increment button
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (_stockCount < 200) _stockCount++;
                      _stockController.text = _stockCount.toString();
                    });
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Update button
            ElevatedButton(
              onPressed: _updateStockCount,
              child: const Text('Update Stock'),
            ),
          ],
        ),
      ),
    );
  }
}
