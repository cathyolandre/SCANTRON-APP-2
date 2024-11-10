import 'package:flutter/material.dart';
import 'models/order_counter.dart';
import 'models/student.dart';
import 'models/stock_provider.dart';
import 'package:provider/provider.dart';
import 'receipt_screen.dart';
import 'welcome_page.dart';  // Import the WelcomePage for navigation
import 'package:cloud_firestore/cloud_firestore.dart';  // Add Firestore import

class OrderScreen extends StatefulWidget {
  final Student student;

  const OrderScreen({super.key, required this.student});

  @override
  OrderScreenState createState() => OrderScreenState();
}

class OrderScreenState extends State<OrderScreen> {
  final OrderCounter _orderCounter = OrderCounter();
  final double pricePerItem = 5.0;

  // Function to update remaining sheets in Firestore
  Future<void> _updateRemainingSheetsInFirestore(Student student) async {
    // Reference to Firestore document for the student
    final studentDocRef = FirebaseFirestore.instance.collection('student.json').doc(student.id);

    // Update the remainingSheets field in Firestore
    await studentDocRef.update({
      'remainingSheets': student.remainingSheets,
    });
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = _orderCounter.orderCount * pricePerItem;
    final stockProvider = Provider.of<StockProvider>(context, listen: false);

    return WillPopScope(  // Using WillPopScope to intercept the back button press
      onWillPop: () async {
        // Navigate to WelcomePage when the back button is pressed
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const WelcomePage()),
          (route) => false, // Removes all previous routes
        );
        return Future.value(false);  // Prevent default back navigation
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('SCANTRON ORDER'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Order Quantity:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('${_orderCounter.orderCount}', style: TextStyle(fontSize: 40, color: Colors.blue)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () => setState(() => _orderCounter.decrement()),
                    icon: Icon(Icons.remove),
                  ),
                  IconButton(
                    onPressed: () => setState(() => _orderCounter.increment()),
                    icon: Icon(Icons.add),
                  ),
                ],
              ),
              Text('Total Price: ₱${totalPrice.toStringAsFixed(2)}', style: TextStyle(fontSize: 18, color: Colors.green)),
              ElevatedButton(
                onPressed: () {
                  int currentStock = stockProvider.stock;
                  if (_orderCounter.orderCount <= widget.student.remainingSheets &&
                      _orderCounter.orderCount <= currentStock) {
                    stockProvider.restock(currentStock - _orderCounter.orderCount);
                    widget.student.remainingSheets -= _orderCounter.orderCount;

                    // Update Firestore to reflect the remaining sheets after the order
                    _updateRemainingSheetsInFirestore(widget.student);

                    stockProvider.addTransaction(_orderCounter.orderCount, totalPrice);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReceiptScreen(
                          orderQuantity: _orderCounter.orderCount,
                          totalPrice: totalPrice,
                          student: widget.student,
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Not enough stock available or insufficient sheets remaining')),
                    );
                  }
                },
                child: Text("Place Order"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
