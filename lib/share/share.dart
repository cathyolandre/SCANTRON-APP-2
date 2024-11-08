import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class SharePage extends StatelessWidget {
  const SharePage({super.key});

  // Function to share a message
  void _shareText() {
    Share.share('Check out this awesome content!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Share Example')),
      body: Center(
        child: ElevatedButton(
          onPressed: _shareText,
          child: Text('Share Text'),
        ),
      ),
    );
  }
}
