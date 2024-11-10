import 'package:flutter/material.dart';
import 'models/order_counter.dart';
import 'models/student.dart';
import 'models/stock_provider.dart';
import 'package:provider/provider.dart';
import 'receipt_screen.dart';
import 'welcome_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderScreen extends StatefulWidget {
  final Student student;

  const OrderScreen({super.key, required this.student});

  @override
  OrderScreenState createState() => OrderScreenState();
}

class OrderScreenState extends State<OrderScreen> {
  final OrderCounter _orderCounter = OrderCounter();
  final double pricePerItem = 5.0;

  Future<void> _updateRemainingSheetsInFirestore(Student student) async {
    final studentDocRef = FirebaseFirestore.instance.collection('student.json').doc(student.id);
    await studentDocRef.update({'remainingSheets': student.remainingSheets});
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = _orderCounter.orderCount * pricePerItem;
    final stockProvider = Provider.of<StockProvider>(context, listen: false);

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const WelcomePage()),
          (route) => false,
        );
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('SCANTRON ORDER'),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'SCANTRON PATRON MACHINE',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Centered Text for Student ID
                Text(
                  'Student ID: ${widget.student.id}',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                // Centered Text for Order Limit
                Text(
                  'Order Limit: ${widget.student.remainingSheets}',
                  style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Order Quantity:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                // Row for Quantity Controls (Add and Decrement buttons)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () => setState(() => _orderCounter.decrement()),
                      icon: const Icon(Icons.remove),
                      iconSize: 50,
                    ),
                    const SizedBox(width: 20),
                    Text(
                      '${_orderCounter.orderCount}',
                      style: const TextStyle(fontSize: 60, color: Colors.blue),
                    ),
                    const SizedBox(width: 20),
                    IconButton(
                      onPressed: () => setState(() => _orderCounter.increment()),
                      icon: const Icon(Icons.add),
                      iconSize: 50,
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                // Centered Total Price Text
                Text(
                  'Total Price: ₱${totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 44, 101, 45)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                // Center the button
                ElevatedButton(
                  onPressed: () async {
                    int currentStock = stockProvider.stock;
                    if (_orderCounter.orderCount <= widget.student.remainingSheets &&
                        _orderCounter.orderCount <= currentStock &&
                        _orderCounter.orderCount > 0) {
                      stockProvider.restock(currentStock - _orderCounter.orderCount);
                      widget.student.remainingSheets -= _orderCounter.orderCount;

                      // Update Firestore
                      await _updateRemainingSheetsInFirestore(widget.student);

                      // Add transaction
                      stockProvider.addTransaction(_orderCounter.orderCount, totalPrice, widget.student.id);

                      // Navigate to ReceiptScreen with required arguments
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReceiptScreen(
                            orderQuantity: _orderCounter.orderCount,
                            totalPrice: totalPrice,
                            student: widget.student,
                            amountPaid: totalPrice, // Pass total price as amount paid
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Not enough stock available or insufficient sheets remaining')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: const Text(
                    "Place Order",
                    style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
