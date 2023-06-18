import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan QR Code'),
      ),
      body: Column(
        children: <Widget>[

          Expanded(
            flex: 4,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await controller?.toggleFlash();
        },
        child: Icon(Icons.camera),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      controller.pauseCamera();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          final List<String> lines = scanData.code!.split('\n');
          String? fullName;
          final List<Map<String, dynamic>> items = [];

          for (final line in lines) {
            if (line.startsWith('Full Name:')) {
              fullName = line.split(': ')[1];
            } else if (line.startsWith('Product Name:')) {
              final parts = line.split(', ');
              final name = parts[0].split(': ')[1];
              final price = double.parse(parts[1].split(': ')[1]);
              final quantity = int.parse(parts[2].split(': ')[1]);
              items.add({'name': name, 'price': price, 'quantity': quantity});
            }
          }

          return AlertDialog(
            title: Text("Sipariş Bilgileri"),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Sipariş Veren Kullanıcı Adı: $fullName\n'),
                for (var i = 0; i < items.length; i++)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ÜRÜN ${i + 1}'),
                      SizedBox(height: 8),
                      Text('Ürün Adı: ${items[i]['name']}'),
                      Text('Sayısı: ${items[i]['quantity']}'),
                      Text('Ücret: ${items[i]['price']}'),
                      Text('Toplam Fiyat: ${items[i]['price'] * items[i]['quantity']}'),
                      SizedBox(height: 16),
                    ],
                  ),
              ],
            ),
            actions: [
              TextButton(
                child: Text('Tamam'),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    result = scanData;
                  });
                  controller.resumeCamera();
                },
              ),
            ],
          );
        },
      );
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}