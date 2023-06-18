import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRGeneratorScreen extends StatefulWidget {
  @override
  _QRGeneratorScreenState createState() => _QRGeneratorScreenState();
}

class _QRGeneratorScreenState extends State<QRGeneratorScreen> {
  String qrData = "";

  @override
  void initState() {
    super.initState();
    fetchLastOrder();
  }

  fetchLastOrder() async {
    final orders = FirebaseFirestore.instance.collection('orders');
    final snapshot = await orders.orderBy('orderDate', descending: true).limit(1).get();

    if (snapshot.docs.isNotEmpty) {
      final order = snapshot.docs.first;
      final fullName = order['fullName'];
      final items = order['items'] as List;

      String itemString = '';
      for (final item in items) {
        itemString += 'Product Name: ${item['productName']}, Product Price: ${item['productPrice']}, Quantity: ${item['quantity']}\n';
      }

      setState(() {
        qrData = 'Full Name: $fullName\nItems:\n$itemString';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Generator'),
      ),
      body: Center(
        child: qrData.isEmpty
            ? CircularProgressIndicator()
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QrImageView(
              data: qrData,
              version: QrVersions.auto,
              size: 200.0,
            ),
            SizedBox(height: 20.0),
            Text(
              'Siparişiniz oluşturulmuştur\nLütfen QR Kodunuzu Kasaya Okutun',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => Navigator.of(context).pushNamed('/homePage'),
          child: Text('Ana Sayfaya Dön'),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.orange),
          ),
        ),
      ),

    );
  }
}
