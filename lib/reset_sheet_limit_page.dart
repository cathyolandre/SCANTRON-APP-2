import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:orderapp/models/student.dart';

const bgColor = Color(0xfffafafa);  // Match your background color style
const buttonColor = Colors.blue;
const textColor = Colors.black;

class ResetSheetLimitPage extends StatefulWidget {
  const ResetSheetLimitPage({super.key, required Student student});

  @override
  _ResetSheetLimitPageState createState() => _ResetSheetLimitPageState();
}

class _ResetSheetLimitPageState extends State<ResetSheetLimitPage> {
  // Function to get initial sheets based on year level
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
        return 0;
    }
  }

  // Function to reset all students' sheet limits, adding remaining balance with a max of 50
  Future<void> resetAllStudentSheetLimits() async {
    try {
      final studentCollection = FirebaseFirestore.instance.collection('student.json');
      
      // Fetch all student documents
      final studentsSnapshot = await studentCollection.get();
      
      for (var studentDoc in studentsSnapshot.docs) {
        int yearLevel = int.tryParse(studentDoc.data()['yearlevel'].toString()) ?? 1;
        int initialSheets = getInitialSheets(yearLevel);
        int currentRemainingSheets = studentDoc.data()['remainingSheets'] ?? 0;

        // Calculate new remaining sheets with a maximum cap of 50
        int updatedRemainingSheets = initialSheets + currentRemainingSheets;
        if (updatedRemainingSheets > 50) {
          updatedRemainingSheets = 50; // Cap the value at 50
        }

        // Update each student's remainingSheets field
        await studentCollection.doc(studentDoc.id).update({
          'remainingSheets': updatedRemainingSheets,
        });
      }
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('All students\' sheet limits have been reset with their remaining balance!'),
        ),
      );
    } catch (e) {
      print('Error resetting sheet limits for all students: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to reset sheet limits!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text(
          'Reset All Sheet Limits',
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: resetAllStudentSheetLimits,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 129, 1, 16),
                minimumSize: const Size(double.infinity, 50),
                padding: const EdgeInsets.symmetric(vertical: 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Reset All Sheet Limits',
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
