import 'package:flutter/material.dart';
import 'view_report_page.dart'; // Make sure this page exists if you have it for reports
import 'inventory_page.dart'; // Make sure this page exists for inventory management

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin Panel',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centers the column content vertically
          crossAxisAlignment: CrossAxisAlignment.center, // Centers the content horizontally
          children: [
            // Header
            Text(
              "Welcome, Admin",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center, // Centers the text horizontally
            ),
            SizedBox(height: 30),

            // Button for viewing reports with rounded corners
            SizedBox(
              width: double.infinity, // Make sure buttons take full width
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ViewReportPage()),
                  );
                },
                icon: Icon(Icons.receipt_long, color: const Color.fromARGB(255, 0, 0, 0)),
                label: Text("View Reports"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 243, 243, 243), // Corrected property name
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Rounded corners
                  ),
                  minimumSize: Size(double.infinity, 50), // Adjust size for the button
                ),
              ),
            ),
            SizedBox(height: 20),

            // Button for managing inventory with rounded corners
            SizedBox(
              width: double.infinity, // Ensure full width for the button
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InventoryPage()),
                  );
                },
                icon: Icon(Icons.inventory, color: const Color.fromARGB(255, 3, 3, 3)),
                label: Text("Manage Inventory"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 243, 243, 243), // Corrected property name
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Rounded corners
                  ),
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Button to navigate back to home with rounded corners
            SizedBox(
              width: double.infinity, // Ensure full width for the button
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context); // Go back to the previous screen
                },
                icon: Icon(Icons.home, color: const Color.fromARGB(255, 0, 0, 0)),
                label: Text("Back to Home"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 243, 243, 243), // Corrected property name
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Rounded corners
                  ),
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
