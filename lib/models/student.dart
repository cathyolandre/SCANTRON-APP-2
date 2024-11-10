import 'package:cloud_firestore/cloud_firestore.dart';

class Student {
  final String id;        // Unique ID for the student (could be their QR code ID)
  final String name;      // Student's name
  final int year;         // Year level of the student (1, 2, 3, or 4)
  int remainingSheets;    // Number of sheets the student can still order

  // Constructor with initial sheet limit based on year level
  Student({
    required this.id,
    required this.name,
    required this.year,
    required this.remainingSheets,
  });

  // Factory constructor to create a Student from Firestore document
  factory Student.fromFirestore(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;
    return Student(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      year: data['year'] ?? 1,  // Default to year 1 if not found
      remainingSheets: (data['remainingSheets'] ?? 0).toInt(),  // Ensure it's an int
    );
  }

  // Method to reset remaining sheets based on year level and existing sheets
  Future<void> resetRemainingSheets() async {
    int newRemainingSheets;

    // Set the new remaining sheets based on year level
    switch (this.year) {
      case 1:
        newRemainingSheets = 30;  // First year students get 30 sheets
        break;
      case 2:
        newRemainingSheets = 20;  // Second year students get 20 sheets
        break;
      case 3:
        newRemainingSheets = 15;  // Third year students get 15 sheets
        break;
      case 4:
        newRemainingSheets = 10;  // Fourth year students get 10 sheets
        break;
      default:
        newRemainingSheets = 0;
    }

    // Add any remaining sheets from the current order that were not used
    newRemainingSheets += this.remainingSheets;

    try {
      // Check if document exists before updating
      var studentDoc = await FirebaseFirestore.instance.collection('student').doc(this.id).get();
      if (studentDoc.exists) {
        // Update Firestore with the new remaining sheets value
        await FirebaseFirestore.instance.collection('student').doc(this.id).update({
          'remainingSheets': newRemainingSheets,
        });

        // Update the student object with the new remaining sheets
        remainingSheets = newRemainingSheets;
      } else {
        print("Student document not found: ${this.id}");
        throw "Student document not found";  // Throw error if document doesn't exist
      }
    } catch (e) {
      print("Error updating student document: $e");
      throw e;  // Re-throw error for further handling
    }
  }

  // Convert the Student object back to a map (for updating the database)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'year': year,
      'remainingSheets': remainingSheets,
    };
  }

  // Fetch updated student from Firestore
  Future<Student> getStudentFromFirestore() async {
    try {
      var studentDoc = await FirebaseFirestore.instance
          .collection('student')
          .doc(id)
          .get();

      if (studentDoc.exists) {
        var data = studentDoc.data();
        return Student(
          id: id,
          name: data?['name'] ?? '',
          year: int.tryParse(data?['year'] ?? '1') ?? 1,
          remainingSheets: data?['remainingSheets'] ?? 0,
        );
      } else {
        print("Student document not found: ${this.id}");
        throw 'Student not found';
      }
    } catch (e) {
      print('Error fetching student data: $e');
      throw 'Error fetching student data';
    }
  }
}
