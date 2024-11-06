import 'package:flutter/material.dart';
import 'package:orderapp/qr_scanner.dart';

class ReceiptScreen extends StatelessWidget {
  final int orderQuantity;
  final double totalPrice;

  // Constructor to pass order quantity and total price to the ReceiptScreen
  const ReceiptScreen({
    super.key,
    required this.orderQuantity,
    required this.totalPrice,
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
            child: Column(
              children: [
                // Back to Home button with icon
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QrScanner()),
                    );
                  },
                  icon: Icon(Icons.home, color: Colors.black), // Add home icon
                  label: Text(
                    'Back to Home',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  ),
                ),
                SizedBox(height: 10), // Spacing between buttons

                // Print Receipt button with icon
                ElevatedButton.icon(
                  onPressed: () {
                    // Implement print functionality here
                  },
                  icon: Icon(Icons.print, color: Colors.black), // Add print icon
                  label: Text(
                    'Print Receipt',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  ),
                ),
              ],
            ),
          )

          ],
        ),
      ),
    );
  }
}