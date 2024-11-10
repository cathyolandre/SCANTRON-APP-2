import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:orderapp/order_screen.dart';
import 'models/student.dart';

const bgColor = Color(0xfffafafa);

class QrScanner extends StatefulWidget {
  const QrScanner({super.key});

  @override
  QrScannerState createState() => QrScannerState();
}

class QrScannerState extends State<QrScanner> {
  String? qrCodeResult;
  bool _isNavigating = false;
  bool _scannerPaused = false; // Flag to control the QR scanner

  // Function to verify the QR code from the combined string
  Future<void> _verifyQRCode(String qrCode) async {
    setState(() => _scannerPaused = true); // Pause scanner

    try {
      if (qrCode.length >= 39) { // Ensure QR code has minimum 39 characters
        String contentHash = qrCode.substring(0, 32);
        String studentId = qrCode.substring(32);

        bool isValid = await _verifyStudent(studentId, contentHash);
        if (isValid && !_isNavigating) {
          Student student = await _getStudentFromFirestore(studentId);

          // If remainingSheets is 0, set it based on the student's year level
          if (student.remainingSheets == 0) {
            student.remainingSheets = getInitialSheets(student.year);
            await FirebaseFirestore.instance
                .collection('student.json')
                .doc(student.id)
                .update({
              'remainingSheets': student.remainingSheets,
            });
          }

          if (mounted) {
            setState(() {
              _isNavigating = true;
            });
          }

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderScreen(student: student),
            ),
          ).then((_) {
            if (mounted) {
              setState(() {
                _isNavigating = false;
                _scannerPaused = false; // Resume scanner after returning
              });
            }
          });
        } else if (!_isNavigating) {
          _showSnackBar("Invalid QR code. Please try again.");
          if (mounted) {
            setState(() => _scannerPaused = false); // Resume scanner on invalid code
          }
        }
      } else {
        _showSnackBar("QR code data is incomplete or invalid.");
        if (mounted) {
          setState(() => _scannerPaused = false); // Resume scanner on invalid code
        }
      }
    } catch (e) {
      _showSnackBar("An error occurred: ${e.toString()}");
      if (mounted) {
        setState(() => _scannerPaused = false); // Resume scanner on error
      }
    }
  }

  // Verify student exists in Firestore
  Future<bool> _verifyStudent(String studentId, String contentHash) async {
    try {
      var studentDoc = await FirebaseFirestore.instance
          .collection('student.json')
          .doc(studentId)
          .get();

      return studentDoc.exists && studentDoc['contenthash'] == contentHash;
    } catch (e) {
      print('Error verifying student: $e');
      return false;
    }
  }

  // Get student data from Firestore
  Future<Student> _getStudentFromFirestore(String studentId) async {
    try {
      var studentDoc = await FirebaseFirestore.instance
          .collection('student.json')
          .doc(studentId)
          .get();

      if (studentDoc.exists) {
        var data = studentDoc.data();
        return Student(
          id: studentId,
          name: data?['name'] ?? '',
          year: int.tryParse(data?['yearlevel'] ?? '1') ?? 1,
          remainingSheets: data?['remainingSheets'] ?? 0,
        );
      } else {
        throw 'Student not found';
      }
    } catch (e) {
      print('Error fetching student data: $e');
      throw 'Error fetching student data';
    }
  }

  // Show Snackbar
  void _showSnackBar(String message) {
    if (!_isNavigating) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  // Get the initial sheet count based on year level
  int getInitialSheets(int yearLevel) {
    switch (yearLevel) {
      case 1:
        return 30;
      case 2:
        return 20;
      case 3:
        return 15;
      case 4:
        return 10;
      default:
        return 0; // Default case if year level is unrecognized
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "SCANTRON PATRON",
              style: TextStyle(
                color: Colors.black,
                fontSize: 35,
                fontWeight: FontWeight.w800,
                letterSpacing: 1,
              ),
            ),
            const Text(
              "SCAN YOUR QR HERE",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 12),
            const SizedBox(height: 20),
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: MobileScanner(
                onDetect: (BarcodeCapture capture) {
                  final barcodes = capture.barcodes;
                  if (barcodes.isNotEmpty && !_scannerPaused) {
                    qrCodeResult = barcodes.first.rawValue;
                    if (qrCodeResult != null) {
                      _verifyQRCode(qrCodeResult!);
                    }
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
