import 'package:flutter/material.dart';
import 'package:orderapp/admin_page.dart';
import 'order_screen.dart';  // Ensure that the OrderPage class is defined in this file

const bgColor = Color(0xfffafafa);

class QrScanner extends StatelessWidget {
  const QrScanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Space at the top
            SizedBox(height: 60),

            // First Expanded for the top content
            Expanded(
              flex: 1,  // Adjust flex to control the height proportion
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "SCANTRON PATRON",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 35,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1,
                    ),
                  ),
                  Text(
                    "SCAN YOUR QR HERE",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(height: 12),
                ],
              ),
            ),

            // Second Expanded for the rounded box and ORDER button
            Expanded(
              flex: 2,  // Adjust flex to control the height proportion
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Rounded Square Box
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  SizedBox(height: 20),

                  // ORDER Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OrderScreen()), // Corrected to OrderPage
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 0, 0, 0),  // Background color
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    ),
                    child: Text(
                      "ORDER",
                      style: TextStyle(
                        color: Colors.white,  // Text color for contrast
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Third Expanded for the SCANTRON APP text and Admin button
            Expanded(
              flex: 1,  // Adjust flex to control the height proportion
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // "SCANTRON APP" Text
                  Text(
                    "SCANTRON APP",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(height: 10),

                  // Admin Button
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AdminPage()),
                      );
                    },
                    icon: Icon(Icons.admin_panel_settings, color: Colors.black),  // Admin icon
                    label: Text(
                      "Admin",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,  // White background for the button
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
