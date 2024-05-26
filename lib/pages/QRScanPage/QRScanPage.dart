// Import the necessary packages
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:bicycle_renting/models/bicycle.dart';

class QRScanPage extends StatefulWidget {
  final Bicycle bookedBicycle;

  QRScanPage({required this.bookedBicycle});

  @override
  _QRScanPageState createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  String? inputText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan QR Code'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: TextField(
              onChanged: (value) {
                inputText = value;
                _compareMakeWithInput();
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Or enter the make of the bicycle here',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _bookBicycle();
            },
            child: Text('Book Bicycle'),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        _compareMakeWithScan();
      });
    });
  }

  void _compareMakeWithScan() {
    if (result != null && result!.code == widget.bookedBicycle.make) {
      // The scanned QR code matches the make of the booked bicycle
      _showMatchFoundDialog();
    }
  }

  void _compareMakeWithInput() {
    if (inputText != null && inputText == widget.bookedBicycle.make) {
      // The entered text matches the make of the booked bicycle
      _showMatchFoundDialog();
    }
  }
  void _showMatchFoundDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Match Found'),
          content: Text('The scanned or entered make matches the make of the booked bicycle.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  void _bookBicycle() {
    // Add your logic here for booking the bicycle
    // For example, you can navigate to a confirmation page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ConfirmationPage()),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

class ConfirmationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirmation'),
      ),
      body: Center(
        child: Text('Your bicycle has been booked!'),
      ),
    );
  }
}
