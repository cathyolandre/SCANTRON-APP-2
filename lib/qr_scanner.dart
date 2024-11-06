import 'package:flutter/material.dart';
import 'order_screen.dart';

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
            // First Expanded for the top content
            SizedBox(height: 60),
            Expanded(
              
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

            // Second Expanded for the rounded box and button
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Rounded Square Box with Only Border
                  Container(
                    width: 200, // Width of the box
                    height: 200, // Height of the box (making it square)
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 103, 33, 243), // Border color
                        width: 3, // Border width
                      ),
                      borderRadius: BorderRadius.circular(20), // Rounded corners
                    ),
                  ),
                  SizedBox(height: 20), // Add spacing between the box and the button

                  // Elevated Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OrderScreen()),
                      );
                    },
                    child: Text(
                      "ORDER",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Third Expanded for the bottom content (SCANTRON APP text)
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "SCANTRON APP",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
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
