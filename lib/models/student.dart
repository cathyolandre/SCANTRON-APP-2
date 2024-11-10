import 'package:cloud_firestore/cloud_firestore.dart';

class Student {
  final String id;
  final String name;
  final int year;
  final String program;
  int remainingSheets;

  Student({
    required this.id,
    required this.name,
    required this.year,
    required this.remainingSheets,
    required this.program,
  });

  factory Student.fromFirestore(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;
    return Student(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      year: data['year'] ?? 1, // Default to year 1 if not found
      remainingSheets: (data['remainingSheets'] ?? 0).toInt(),
      program: data['program'] ?? '', // Ensure program is fetched correctly
    );
  }

  Future<void> resetRemainingSheets() async {
    int newRemainingSheets;

    switch (year) {
      case 1:
        newRemainingSheets = 30;
        break;
      case 2:
        newRemainingSheets = 20;
        break;
      case 3:
        newRemainingSheets = 15;
        break;
      case 4:
        newRemainingSheets = 10;
        break;
      default:
        newRemainingSheets = 0;
    }

    newRemainingSheets += remainingSheets;

    try {
      var studentDoc = await FirebaseFirestore.instance.collection('student').doc(id).get();
      if (studentDoc.exists) {
        await FirebaseFirestore.instance.collection('student').doc(id).update({
          'remainingSheets': newRemainingSheets,
        });

        remainingSheets = newRemainingSheets;
      } else {
        print("Student document not found: $id");
        throw "Student document not found";
      }
    } catch (e) {
      print("Error updating student document: $e");
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'year': year,
      'program': program,
      'remainingSheets': remainingSheets,
    };
  }

  Future<Student> getStudentFromFirestore() async {
    try {
      var studentDoc = await FirebaseFirestore.instance.collection('student').doc(id).get();

      if (studentDoc.exists) {
        var data = studentDoc.data();
        return Student(
          id: id,
          name: data?['name'] ?? '',
          year: int.tryParse(data?['year'].toString() ?? '1') ?? 1,
          remainingSheets: (data?['remainingSheets'] ?? 0).toInt(),
          program: data?['program'] ?? '',  // Ensure program is being fetched
        );
      } else {
        print("Student document not found: $id");
        throw 'Student not found';
      }
    } catch (e) {
      print('Error fetching student data: $e');
      throw 'Error fetching student data';
    }
  }
}
