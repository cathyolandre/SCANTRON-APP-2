import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

class QRCodeGenerationPage extends StatefulWidget {
  const QRCodeGenerationPage({super.key});

  @override
  QRCodeGenerationPageState createState() => QRCodeGenerationPageState();
}

class QRCodeGenerationPageState extends State<QRCodeGenerationPage> {
  final TextEditingController _customerInfoController = TextEditingController();
  String _qrData = '';

  // Function to generate a unique code for the customer based on entered info
  String _generateUniqueCode(String customerInfo) {
    // Example unique identifier based on customer info and timestamp
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return 'CUSTOMER-$customerInfo-$timestamp';
  }

  // Function to handle QR code generation and storage
  Future<void> _generateAndSaveQRCode() async {
    final customerInfo = _customerInfoController.text;
    if (customerInfo.isEmpty) return;  // Ensure info is provided

    final uniqueCode = _generateUniqueCode(customerInfo);

    // Store the generated code for this customer in Firestore
    await _storeCustomerCode(customerInfo, uniqueCode);

    setState(() {
      _qrData = uniqueCode;
    });
  }

  // Function to store customer code in Firestore
  Future<void> _storeCustomerCode(String customerInfo, String code) async {
    try {
      // Reference to Firestore collection
      final collection = FirebaseFirestore.instance.collection('customer_codes');

      // Store customer code in the Firestore collection
      await collection.add({
        'customer_info': customerInfo,  // Store customer info (e.g., name or ID)
        'unique_code': code,            // Store the generated code
        'timestamp': FieldValue.serverTimestamp(),  // Save timestamp
      });

      if (kDebugMode) {
        print("Customer code stored successfully!");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error storing customer code: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Code Generator"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _customerInfoController,
              decoration: InputDecoration(
                labelText: "Enter Customer Info (e.g., ID or Name)",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _generateAndSaveQRCode,
              child: Text("Generate QR Code"),
            ),
            SizedBox(height: 40),
            if (_qrData.isNotEmpty)
              Column(
                children: [
                  QrImageView(
                    data: _qrData,
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "QR Code Generator",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
