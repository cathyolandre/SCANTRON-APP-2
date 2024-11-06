import 'package:flutter/material.dart';
import 'package:orderapp/qr_scanner.dart';
import 'package:provider/provider.dart'; // Import the provider package
import 'models/stock_provider.dart'; // Import the stock provider (we will create this next)

void main() {
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
