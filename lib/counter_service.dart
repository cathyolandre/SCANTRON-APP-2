import 'package:cloud_firestore/cloud_firestore.dart';

class CounterService {
  // Function to get and update the counter in Firestore
  static Future<String> getAndUpdateCounter() async {
    final counterRef = FirebaseFirestore.instance.collection('counter').doc('counterDocument');

    // Get the current counter value
    DocumentSnapshot snapshot = await counterRef.get();

    // Get the current counter and increment it
    int currentCounter = snapshot.exists ? snapshot['counter'] : 0;
    int newCounter = currentCounter + 1;

    // Update the counter in the Firestore document
    await counterRef.update({'counter': newCounter});

    // Return the formatted counter (6 digits)
    return newCounter.toString().padLeft(6, '0');
  }
}
