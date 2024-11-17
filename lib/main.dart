import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: QRGeneratorScreen(),
    );
  }
}

class QRGeneratorScreen extends StatefulWidget {
  @override
  _QRGeneratorScreenState createState() => _QRGeneratorScreenState();
}

class _QRGeneratorScreenState extends State<QRGeneratorScreen> {
  final TextEditingController _textController = TextEditingController();
  String _qrData = "";

  void _generateQRCode() {
    setState(() {
      _qrData = _textController.text.trim();
    });
  }

  void _shareQRCode() {
    if (_qrData.isNotEmpty) {
      Share.share(_qrData, subject: 'QR Code Data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Generator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                labelText: 'Enter data for QR Code',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _generateQRCode,
              child: const Text('Generate QR Code'),
            ),
            const SizedBox(height: 16.0),
            if (_qrData.isNotEmpty)
              Column(
                children: [
                  QrImage(
                    data: _qrData, // Pass the QR data here
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _shareQRCode,
                    child: const Text('Share QR Code Data'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
