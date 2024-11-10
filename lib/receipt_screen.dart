import 'package:flutter/material.dart';
import 'package:orderapp/models/student.dart';
import 'package:orderapp/welcome_page.dart';

class ReceiptScreen extends StatelessWidget {
  final int orderQuantity;
  final double totalPrice;

  // Constructor to pass order quantity and total price to the ReceiptScreen
  const ReceiptScreen({
    super.key,
    required this.orderQuantity,
    required this.totalPrice,
    required Student student,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Receipt Header
            Text(
              'Receipt',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            
            // Order details
            Text(
              'Item: Scantron Paper',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Text(
              'Quantity: $orderQuantity',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),

            SizedBox(height: 40),
            Divider(),
            SizedBox(height: 5),

            // Price per item
            Text(
              'Price per item: ₱5.00',  // Fixed price for paper
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),

            // Total Price
            Text(
              'Total: ₱${totalPrice.toStringAsFixed(2)}',  // Total price
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 20),

            // Thank you message
            Text(
              'Thank you for your order!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 50),

            // Option to go back to the main screen or home
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WelcomePage()),
                  );
                },
                icon: Icon(
                  Icons.home, 
                  color: Colors.black, 
                  size: 24, // Adjust icon size as needed
                ),
                label: SizedBox.shrink(), // No text label, just the icon
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25), // Adjust button padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Optional: rounded corners for button
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
