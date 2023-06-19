import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
    controller.scannedDataStream.listen((scanData) async {
      controller.pauseCamera();

      final String orderId = scanData.code!;
      final orderDoc = await FirebaseFirestore.instance.collection('orders').doc(orderId).get();
      final currentUser = _auth.currentUser;

      if (currentUser != null && orderDoc.exists) {
        final orderVendorId = orderDoc['vendorId'];
        final currentUserId = currentUser.uid;

        if (orderVendorId != currentUserId) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Invalid Order'),
                content: Text('This order is from another store.'),
                actions: [
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      controller.resumeCamera();
                    },
                  ),
                ],
              );
            },
          );
          return;
        }
      }

      bool isPickedUp = orderDoc['isPickedUp'];
      if (isPickedUp) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Order has been picked up'),
              content: Text('This order has already been picked up.'),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    controller.resumeCamera();
                  },
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            final fullName = orderDoc['fullName'];
            final phone = orderDoc['phone'];
            final items = orderDoc['items'] as List;
            return AlertDialog(
              title: Text("Order Informations"),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Ordered Customer: $fullName'),
                    Text('Phone: $phone'),
                    for (final item in items)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Product Name: ${item['productName']}'),
                          Text('Quantity: ${item['quantity']}'),
                          Text('Product Price: ${item['productPrice']}'),
                          SizedBox(height: 16),
                        ],
                      ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: Text('Tamam'),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    setState(() {
                      result = scanData;
                    });

                    // Set 'isPickedUp' value to true
                    await FirebaseFirestore.instance
                        .collection('orders')
                        .doc(orderId)
                        .update({'isPickedUp': true});

                    controller.resumeCamera();
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
