import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import the provider package
import 'package:orderapp/qr_scanner.dart';  // Assuming this is where your QR scanner is located
import 'admin_page.dart';
import 'models/student.dart'; // Import the Student model if needed
import 'models/stock_provider.dart';  // Import StockProvider to check stock
import 'stock_warning_page.dart';  // Import the StockWarningPage

const bgColor = Color(0xfffafafa);

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get current stock from StockProvider
    final stockRemaining = Provider.of<StockProvider>(context).stock;

    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        children: [
          const Spacer(), // Pushes everything below towards the center
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "WELCOME TO SCANTRON PATRON",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 50,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    // If stock is low (<= 30), show the StockWarningPage
                    if (stockRemaining <= 30) {
                      showDialog(
                        context: context,
                        builder: (context) => StockWarningPage(stockRemaining: stockRemaining),
                      );
                    } else {
                      // Navigate to QR scanner directly if stock is sufficient
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const QrScanner()),
                      );
                    }
                  },
                  icon: const Icon(Icons.qr_code, color: Colors.black),
                  label: const Text(
                    "LOG IN SCAN",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(), // Pushes Admin button to the bottom
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0), // Add some space from the bottom edge
            child: ElevatedButton.icon(
              onPressed: () {
                _showPasswordDialog(context); // Show password dialog before navigating to AdminPage
              },
              icon: const Icon(Icons.admin_panel_settings, color: Colors.black),
              label: const Text(
                "Admin",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Password Dialog
  void _showPasswordDialog(BuildContext context) {
    final TextEditingController passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Admin Password'),
          content: TextField(
            controller: passwordController,
            obscureText: true, // Hide the text for security
            decoration: const InputDecoration(
              hintText: 'Password',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                String enteredPassword = passwordController.text;
                if (enteredPassword == '1234') {  // Replace 'yourPasswordHere' with your admin password
                  Navigator.pop(context);  // Close the dialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminPage(
                        student: Student(id: "1", name: "Test Student", year: 1, remainingSheets: 30, program: ''),
                      ),
                    ),
                  );
                } else {
                  // Show error if password is incorrect
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Incorrect password')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);  // Close the dialog without action
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
