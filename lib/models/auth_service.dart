import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  // Function to verify student by ID and content hash
  static Future<bool> verifyStudent(String id, String contentHash) async {
    try {
      var studentDoc = await FirebaseFirestore.instance
          .collection('students') // Firestore collection
          .doc(id) // Document ID is the student ID
          .get();

      if (studentDoc.exists) {
        var data = studentDoc.data();
        if (data?['contentHash'] == contentHash) {
          return true;  // Valid QR code
        }
      }
      return false;  // Invalid QR code
    } catch (e) {
      if (kDebugMode) {
        print('Error verifying student: $e');
      }
      return false;
    }
  }

  // Function to get the order limit based on the student's year level
  static Future<int> getOrderLimit(String id) async {
    try {
      var studentDoc = await FirebaseFirestore.instance
          .collection('students')
          .doc(id)
          .get();

      var yearLevel = studentDoc.data()?['yearLevel'];
      int orderLimit;

      if (yearLevel == 1) {
        orderLimit = 30; // First-year student
      } else if (yearLevel == 2) {
        orderLimit = 20; // Second-year student
      } else {
        orderLimit = 10; // Default for other years
      }

      return orderLimit;
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching order limit: $e');
      }
      return 0;
    }
  }

  // Function to update the remaining sheets after an order
  static Future<void> updateRemainingSheets(String id, int remainingSheets) async {
    try {
      await FirebaseFirestore.instance
          .collection('students')
          .doc(id)
          .update({
        'remainingSheets': remainingSheets,
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error updating remaining sheets: $e');
      }
    }
  }
}
