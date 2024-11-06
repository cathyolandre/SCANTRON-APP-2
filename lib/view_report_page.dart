import 'package:flutter/material.dart';

class Report {
  final int orderQuantity;
  final double totalPrice;
  final DateTime date;

  Report({required this.orderQuantity, required this.totalPrice, required this.date});
}

class ViewReportPage extends StatelessWidget {
 ViewReportPage({super.key});

  // Sample data for the report
  final List<Report> reports = [
    Report(orderQuantity: 5, totalPrice: 25.0, date: DateTime.now().subtract(Duration(days: 1))),
    Report(orderQuantity: 3, totalPrice: 15.0, date: DateTime.now().subtract(Duration(days: 2))),
    Report(orderQuantity: 7, totalPrice: 35.0, date: DateTime.now().subtract(Duration(days: 3))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Reports',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
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
            
            // List of reports
            Expanded(
              child: ListView.builder(
                itemCount: reports.length,
                itemBuilder: (context, index) {
                  final report = reports[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: Icon(Icons.receipt_long, color: Colors.teal),
                      title: Text(
                        'Order Date: ${report.date.toLocal()}'.split(' ')[0],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Quantity: ${report.orderQuantity}'),
                          Text('Total Price: ₱${report.totalPrice.toStringAsFixed(2)}'),
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
