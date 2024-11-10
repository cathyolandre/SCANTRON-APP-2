import 'package:flutter/material.dart';
import 'reset_sheet_limit_page.dart';  // Make sure this import is correct and used
import 'view_report_page.dart';  
import 'inventory_page.dart';  
import 'models/student.dart' as student_model;  // Correct prefix

class AdminPage extends StatelessWidget {
  final student_model.Student student;  // Correctly refer to the student model

  const AdminPage({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin Panel',
          style: TextStyle(
            color: const Color.fromARGB(255, 255, 255, 255),
            fontSize: 18,
            fontWeight: FontWeight.w500,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          crossAxisAlignment: CrossAxisAlignment.center, 
          children: [
            // Header
            Text(
              "Welcome, Admin",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center, 
            ),
            SizedBox(height: 30),

            // Button for viewing reports with rounded corners
            SizedBox(
              width: double.infinity, 
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ViewReportPage()),
                  );
                },
                icon: Icon(Icons.receipt_long, color: Colors.black, size: 40),
                label: SizedBox.shrink(), 
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 243, 243, 243),
                  padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Button for managing inventory with rounded corners
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InventoryPage()),
                  );
                },
                icon: Icon(Icons.inventory, color: Colors.black, size: 40),
                label: SizedBox.shrink(), 
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 243, 243, 243),
                  padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Button to reset sheet limit with rounded corners
            SizedBox(
              width: double.infinity, 
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ResetSheetLimitPage(student: student)),
                  );
                },
                icon: Icon(Icons.reset_tv_rounded, color: Colors.black, size: 40),
                label: SizedBox.shrink(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 243, 243, 243),
                  padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Button to navigate back to home with rounded corners
            SizedBox(
              width: double.infinity, 
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.home, color: Colors.black, size: 40),
                label: SizedBox.shrink(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 243, 243, 243),
                  padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
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
