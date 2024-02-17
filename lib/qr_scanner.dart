import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner/result_screen.dart';

class QRScanner extends StatefulWidget {
  const QRScanner({super.key});

  @override
  State<QRScanner> createState() => _QRScanner();
}

class _QRScanner extends State<QRScanner> {
  bool isScanCompleted = false;
  bool isFlashLightOn = false;
  bool isFrontCameraOn = false;

  void handleCloseScreen() {
    isScanCompleted = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(21),
      child: Column(
        children: [
          const Expanded(
            child: Column(
              children: [
                Text(
                  "Place the QR Code in this area",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Scanning will be started automatically",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                MobileScanner(
                  allowDuplicates: true,
                  onDetect: (barcode, args) {
                    if (!isScanCompleted) {
                      String mCode = barcode.rawValue ?? "---";
                      isScanCompleted = true;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResultScreen(
                                mCode: mCode,
                                handleCloseScreen: handleCloseScreen,
                              )));
                    }
                  },
                ),
                // Scanner Overlay
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.red, // Customize the border color
                        width: 2.0, // Customize the border width
                      ),
                    ),
                    margin: const EdgeInsets.all(16.0), // Customize the margin
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: const Text(
                "Developed By Umar",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
