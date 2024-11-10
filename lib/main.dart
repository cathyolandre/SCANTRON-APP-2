import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart'; // Import the QR scanner page
import 'package:orderapp/welcome_page.dart'; // Import the WelcomePage
import 'package:provider/provider.dart'; 
import 'models/stock_provider.dart'; 
import 'package:firebase_core/firebase_core.dart'; 
import 'firebase_options.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase based on platform
  try {
    if (kIsWeb) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.web, // Use generated Firebase options for web
      );
    } else {
      await Firebase.initializeApp(); // Use default initialization for mobile platforms
    }
    if (kDebugMode) {
      print("Firebase initialized successfully.");
    }
  } catch (e) {
    if (kDebugMode) {
      print("Error initializing Firebase: $e");
    }
    return; // If initialization fails, prevent the app from running
  }

  // Run the app after Firebase has been initialized successfully
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
      home: const WelcomePage(), // Start with the WelcomePage
      debugShowCheckedModeBanner: false,
      title: 'Scantron App',
    );
  }
}
