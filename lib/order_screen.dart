import 'package:flutter/material.dart';
import 'models/order_counter.dart'; // Import the public OrderCounter class
import 'receipt_screen.dart'; // Import the receipt screen

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  OrderScreenState createState() => OrderScreenState();
}

class OrderScreenState extends State<OrderScreen> {
  // Create an instance of OrderCounter
  final OrderCounter _orderCounter = OrderCounter();

  // Price per item
  final double pricePerItem = 5.0; // Example price per paper

  @override
  Widget build(BuildContext context) {
    // Calculate total price
    double totalPrice = _orderCounter.orderCount * pricePerItem;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SCANTRON ORDER',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Order counter display
            Text(
              'Order Quantity:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            SizedBox(height: 20),
            // Display the current order count
            Text(
              '${_orderCounter.orderCount}',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 20),
            // Buttons to increment or decrement the order count
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      _orderCounter.decrement();
                    });
                  },
                  icon: Icon(Icons.remove, color: Colors.black),
                ),
                SizedBox(width: 20),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _orderCounter.increment();
                    });
                  },
                  icon: Icon(Icons.add, color: Colors.black),
                ),
              ],
            ),
            SizedBox(height: 30),
            
            // Price display at the bottom
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                'Total Price: ₱${totalPrice.toStringAsFixed(2)}',  // Display total price
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                  letterSpacing: 1,
                ),
              ),
            ),
            SizedBox(height: 1),
            // Submit Order Button
            ElevatedButton(
              onPressed: () {
                // Navigate to the receipt screen with order details
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReceiptScreen(
                      orderQuantity: _orderCounter.orderCount,
                      totalPrice: totalPrice,
                    ),
                  ),
                );
              },
              child: Text(
                "Place Order",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
