import 'package:flutter/material.dart';

class Support extends StatelessWidget {
  const Support({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customer Support"),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(  // Wrap the entire Column inside a Center widget
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,  // Center vertically
            crossAxisAlignment: CrossAxisAlignment.center,  // Center horizontally
            children: [
              const Text(
                "LOW ON SCANTRON SHEETS?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Please contact the IABF office for restocking! :)",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
