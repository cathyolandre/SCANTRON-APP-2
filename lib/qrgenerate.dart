import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

const bgColor = Color(0xfffafafa);

class Qrgenerate extends StatefulWidget {
  const Qrgenerate({super.key});

  @override
  _QrgenerateState createState() => _QrgenerateState();
}

class _QrgenerateState extends State<Qrgenerate> {
  String? qrData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(
          'QR KEY',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Set the color to white
          onPressed: () {
            Navigator.pop(context); // Pops the current screen and goes back to the previous screen
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Space at the top
            SizedBox(height: 60),

            // Heading text
            Text(
              "QR CODE GENERATOR",
              style: TextStyle(
                color: Colors.black,
                fontSize: 35,
                fontWeight: FontWeight.w800,
                letterSpacing: 1,
              ),
            ),
            Text(
              "ENTER DATA BELOW",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            SizedBox(height: 12),

            // TextField for QR data input
            TextField(
              onSubmitted: (value) {
                setState(() {
                  qrData = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Enter QR Data',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              ),
              textInputAction: TextInputAction.done,
            ),
            SizedBox(height: 20),

            // Generate QR Code if data is entered
            if (qrData != null && qrData!.isNotEmpty)
              PrettyQr(
                data: qrData!,
                size: 200,
                errorCorrectLevel: QrErrorCorrectLevel.H,
                typeNumber: 3,
                roundEdges: true,
              ),
            if (qrData == null || qrData!.isEmpty)
              Text(
                'Enter some data to generate a QR code.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            SizedBox(height: 20),

            // Submit Button to trigger QR generation
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // Triggering the QR code generation on button press
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              ),
              child: Text(
                "Generate QR",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
