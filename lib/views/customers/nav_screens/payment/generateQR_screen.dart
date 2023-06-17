import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRGeneratorScreen extends StatefulWidget {
  @override
  _QRGeneratorScreenState createState() => _QRGeneratorScreenState();
}

class _QRGeneratorScreenState extends State<QRGeneratorScreen> {
  CollectionReference ordersCollection = FirebaseFirestore.instance.collection('orders');
  CollectionReference qrCodesCollection = FirebaseFirestore.instance.collection('qrcodes');

 String getText(){
   Map<String, dynamic> orderData = document.data() as Map<String, dynamic>;


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Generator'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: ordersCollection.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          // Display order information and generate QR codes
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> orderData = document.data() as Map<String, dynamic>;
              return ListTile(
                title: Text('Order ID: ${orderData['orderId']}'),
                subtitle: Text('Product Name: ${orderData['fullName']}'),
                trailing: QrImageView(
                  data: "str",
                  size: 100.0,
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}