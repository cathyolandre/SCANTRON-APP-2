import 'package:flutter/material.dart';
import 'package:orderapp/qr_scanner.dart';
import 'admin_page.dart'; // Ensure this is added at the top of your WelcomePage.dart
import 'models/student.dart'; // Import the Student model if needed

const bgColor = Color(0xfffafafa);

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "WELCOME TO THE SCANTRON APP",
              style: TextStyle(
                color: Colors.black,
                fontSize: 35,
                fontWeight: FontWeight.w800,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                // Navigate to QR scanner
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QrScanner()),
                );
              },
              icon: const Icon(Icons.qr_code, color: Colors.black),
              label: const Text(
                "LOG IN SCAN",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                // Assuming you're passing the student object to AdminPage
                // Replace `student` with a valid object from your app logic
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminPage(student: Student(id: "1", name: "Test Student", year: 1, remainingSheets: 30)),
                  ),
                );
              },
              icon: const Icon(Icons.admin_panel_settings, color: Colors.black),
              label: const Text(
                "Admin",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
