import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Add Firebase Firestore package

class QRCodeGenerationPage extends StatefulWidget {
  const QRCodeGenerationPage({super.key});

  @override
  QRCodeGenerationPageState createState() => QRCodeGenerationPageState();
}

class QRCodeGenerationPageState extends State<QRCodeGenerationPage> {
  final TextEditingController _customerInfoController = TextEditingController();
  String _qrData = '';
  final ScreenshotController _screenshotController = ScreenshotController();

  // Initialize Firebase and Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _generateUniqueCode(String customerInfo) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return 'CUSTOMER-$customerInfo-$timestamp';
  }

  // Save QR code data to Firebase Firestore
  Future<void> _saveQRCodeDataToFirestore(String customerInfo, String qrData) async {
    try {
      await _firestore.collection('qr_codes').add({
        'customerInfo': customerInfo,
        'qrData': qrData,
        'timestamp': FieldValue.serverTimestamp(),
      });
      debugPrint('QR Code saved to Firestore!');
    } catch (e) {
      debugPrint("Error saving QR code to Firestore: $e");
    }
  }

  Future<void> _generateAndSaveQRCode() async {
    final customerInfo = _customerInfoController.text;
    if (customerInfo.isEmpty) return;

    final uniqueCode = _generateUniqueCode(customerInfo);

    if (!mounted) return;
    setState(() {
      _qrData = uniqueCode;
    });

    // Save the generated QR code data to Firestore
    await _saveQRCodeDataToFirestore(customerInfo, uniqueCode);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('QR Code generated and saved to Firestore!')),
      );
    }
  }

  Future<void> _downloadQRCode() async {
    final directory = await getExternalStorageDirectory();
    if (directory == null) {
      debugPrint("Error: Directory not found!");
      return;
    }

    final filePath = '${directory.path}/qr_code.png';  // Check file path
    debugPrint("Saving QR Code to: $filePath");

    _screenshotController.captureAndSave(directory.path, fileName: "qr_code.png").then((value) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('QR Code saved to: $filePath')),
        );
      }
    }).catchError((e) {
      debugPrint("Error saving QR Code: $e");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("QR Code Generator")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _customerInfoController,
              decoration: InputDecoration(labelText: "Enter Customer Info"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _generateAndSaveQRCode,
              child: Text("Generate QR Code"),
            ),
            SizedBox(height: 150),
            Screenshot(
              controller: _screenshotController,
              child: Column(
                children: [
                  if (_qrData.isNotEmpty)
                    QrImageView(
                      data: _qrData,
                      version: QrVersions.auto,
                      size: 200.0,
                    ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _downloadQRCode,
                    child: Text("Download QR Code"),
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
