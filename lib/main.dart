import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:orderapp/qr_scanner.dart';
import 'package:provider/provider.dart'; // Import the provider package
import 'models/stock_provider.dart'; // Import the stock provider (we will create this next)
import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core
import 'firebase_options.dart'; // You'll generate this file after setting up Firebase

void main() {
WidgetsFlutterBinding.ensureInitialized();

  if(kIsWeb){
    Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDiVDa2z7rPoljZXFUDKcpOLv9fqkOkw0k",
        authDomain: "scantron-app.firebaseapp.com",
        projectId: "scantron-app",
        storageBucket: "scantron-app.firebasestorage.app",
        messagingSenderId: "716693143326",
        appId: "1:716693143326:web:4cc98c2cb16a0bc6d4530f",
        measurementId: "G-38FYX5LZGD"));
    
  } else {
    Firebase.initializeApp();
  }
  
  runApp(
    ChangeNotifierProvider(
      create: (_) => StockProvider(), // Initialize StockProvider at the top of the app
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
      ),
      home: const QrScanner(), // Start with the QR Scanner page
      debugShowCheckedModeBanner: false,
      title: 'Scantron App',
    );
  }
}
