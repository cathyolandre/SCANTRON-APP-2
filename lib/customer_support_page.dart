import 'package:flutter/material.dart';
import 'welcome_page.dart'; // Import the WelcomePage

class CustomerSupportPage extends StatelessWidget {
  const CustomerSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
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
              // Home button to navigate to WelcomePage
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WelcomePage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  backgroundColor: Colors.teal,
                ),
                child: const Text(
                  "HOME",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
