import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';  // Import for QR code scanning
import 'package:url_launcher/url_launcher.dart';  // Import for launching URL

void main() {
  runApp(MyApp()); // Entry point to run the app
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Scanner App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QRScannerScreen(), // Main screen
    );
  }
}

class QRScannerScreen extends StatefulWidget {
  @override
  _QRScannerScreenState createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  final GlobalKey _qrKey = GlobalKey();
  String _qrData = '';

  void _onQRScanned(String? data) {
    if (data != null) {
      setState(() {
        _qrData = data;
      });

      _openFile(data);
    }
  }

  Future<void> _openFile(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Scanner'),
      ),
      body: Column(
        children: [
          Expanded(
            child: QRView(
              key: _qrKey,
              onQRViewCreated: (QRViewController controller) {
                controller.scannedDataStream.listen((scanData) {
                  _onQRScanned(scanData.code);
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Scanned Data: $_qrData',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
