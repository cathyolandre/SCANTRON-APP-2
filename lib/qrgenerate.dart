import 'package:flutter/material.dart';

class Qrgenerate extends StatelessWidget {
  const Qrgenerate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR KEY'),
        centerTitle: true,  // Centers the title
      ),
      body: Center(
        child: Text('Hello, World!'),
      ),
    );
  }
}
