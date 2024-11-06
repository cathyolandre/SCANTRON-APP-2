import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class Qrscan extends StatelessWidget {
  const Qrscan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SCANNER'),
        centerTitle: true,  // Centers the title
      ),
      body: MobileScanner(
        controller: MobileScannerController(detectionSpeed: DetectionSpeed.normal),
        onDetect: (capture){
          final List<Barcode> barcodes = capture.barcodes;
          final Uint8List ? image = capture.image;
          for (final barcode in barcodes){
            if(image != null){
              showDialog(context: 
              context, builder: (context){
                return AlertDialog(
                  title: Text(
                    barcodes.first.rawValue ?? "",
                  ),
                  content: Image(image: MemoryImage(image),
                  ),
                );
              },
              );
            }
          }
      },
      ),
    );
  }
}
