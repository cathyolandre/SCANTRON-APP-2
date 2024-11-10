import 'package:flutter/material.dart';
import 'models/student.dart' as student_model;  // Import student model

class ResetSheetLimitPage extends StatefulWidget {
  final student_model.Student student;  // Receiving the student model

  const ResetSheetLimitPage({Key? key, required this.student}) : super(key: key);

  @override
  _ResetSheetLimitPageState createState() => _ResetSheetLimitPageState();
}

class _ResetSheetLimitPageState extends State<ResetSheetLimitPage> {
  late int remainingSheets;

  @override
  void initState() {
    super.initState();
    remainingSheets = widget.student.remainingSheets; // Accessing the remainingSheets field
  }

  // Function to reset the sheet limit
  void resetLimit() async {
    try {
      // Call the method to reset the remaining sheets
      await widget.student.resetRemainingSheets();

      // Fetch the updated student data from Firestore
      student_model.Student updatedStudent = await widget.student.getStudentFromFirestore();

      // Update the UI with the new value
      setState(() {
        remainingSheets = updatedStudent.remainingSheets;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sheet limit has been reset!')),
      );
    } catch (e) {
      print('Error resetting sheet limit: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to reset sheet limit!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Sheet Limit'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Displaying current student info
            Text(
              'Student: ${widget.student.name}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Current Sheet Limit: $remainingSheets', // Use remainingSheets here
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 30),

            // Button to reset the sheet limit
            ElevatedButton(
              onPressed: () {
                resetLimit(); // Call the function to reset the limit
              },
              child: Text('Reset Sheet Limit'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                padding: EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.blue,  // Use backgroundColor instead of primary
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Back button
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);  // Go back to previous screen
              },
              child: Text('Back'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                padding: EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.grey,  // Use backgroundColor instead of primary
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
