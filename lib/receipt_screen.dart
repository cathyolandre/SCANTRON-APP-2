import 'package:flutter/material.dart';
import 'package:orderapp/models/student.dart';
import 'package:orderapp/welcome_page.dart';

class ReceiptScreen extends StatelessWidget {
  final int orderQuantity;
  final double totalPrice;
  final Student student;
  final double amountPaid; // The amount the student paid

  const ReceiptScreen({
    super.key,
    required this.orderQuantity,
    required this.totalPrice,
    required this.student,
    required this.amountPaid,  // Expect the amountPaid here
  });

  @override
  Widget build(BuildContext context) {
    // Calculate the change due
    double changeDue = amountPaid - totalPrice;

    // Generate a unique counter (for demonstration purposes, we'll just use a fixed counter here)
    int counter = 1; // This should ideally come from a database or increment with each new receipt

    // Format the Sale Invoice Number: "SP" + Year + Counter
    String saleInvoiceNumber = 'SP${DateTime.now().year.toString().substring(2)}${counter.toString().padLeft(6, '0')}';

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 150), // Space at the top for centering

            // Header Section with IABF Student Council on the left and Sale Invoice # on the right
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'IABF Student Council',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Institute of Accounts, Business and Finance',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                Text(
                  'Sale Invoice #: $saleInvoiceNumber', // Updated invoice number format
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Student Details Section
            Text(
              'Issued to',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Name: ${student.name}',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Student Number: ${student.id}',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Order Date: ${DateTime.now().toString().split(' ')[0]}',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Table Header
            Container(
              decoration: BoxDecoration(
                border: Border.all(),
                color: Colors.grey.shade300,
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Description',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Quantity',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Amount',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Table Row
            Container(
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Text(
                        'Scantron Sheet/s',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Text(
                        '$orderQuantity',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Text(
                        '₱${totalPrice.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20), // Space between table and footer

            // Total Amount Section
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Total Amount: ₱${totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10), // Space between amounts

            // Amount Paid Section
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Amount Paid: ₱${amountPaid.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Change Due Section
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Change Due: ₱${changeDue.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
                ),
              ],
            ),

            const Spacer(), // Pushes the remaining content to the bottom

            // Add the SCANTRON PATRON MACHINE text at the bottom, centered
            Align(
              alignment: Alignment.bottomCenter, // Aligns it to the bottom center
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'SCANTRON PATRON MACHINE',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            // Space between text and button
            const SizedBox(height: 10),

            // Back to Welcome Page Button, centered at the bottom
            Align(
              alignment: Alignment.bottomCenter, // Aligns it to the bottom center
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const WelcomePage()),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: const Text('Back to Welcome Page',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
