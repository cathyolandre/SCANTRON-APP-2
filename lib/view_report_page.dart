import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/stock_provider.dart';
import 'package:intl/intl.dart'; // Import intl package for date formatting

class Report {
  final int orderQuantity;
  final double totalPrice;
  final DateTime date;
  final String studentId; // Added studentId to the Report model

  Report({required this.orderQuantity, required this.totalPrice, required this.date, required this.studentId});
}

class ViewReportPage extends StatelessWidget {
  const ViewReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the list of transactions from StockProvider
    final transactions = Provider.of<StockProvider>(context).transactions;

    // Create a DateFormat instance to format the date
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Reports',
          style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 0, 63, 57),
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Order Report",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final report = transactions[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: Icon(Icons.receipt_long, color: Colors.teal),
                      title: Text(
                        'Order Date: ${dateFormat.format(report.date)}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Quantity: ${report.orderQuantity}'),
                          Text('Total Price: ₱${report.totalPrice.toStringAsFixed(2)}'),
                          Text('Student ID: ${report.studentId}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)), // Displaying the student ID
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
