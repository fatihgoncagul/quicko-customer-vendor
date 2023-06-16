import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GenerateQRScreen extends StatelessWidget {
  const GenerateQRScreen({Key? key}) : super(key: key);

  Future<String> getQrDataFromFirestore() async {
    var uid = FirebaseAuth.instance.currentUser!.uid;

    DocumentSnapshot docSnap = await FirebaseFirestore.instance.collection('QR').doc(uid).get();
    Map<String, dynamic>? data = docSnap.data() as Map<String, dynamic>?;

    String qrData = '';

    // Belgedeki tüm alanları alıp QR verisini oluşturuyoruz.
    if (data != null) {
      data.forEach((key, value) {
        qrData += value + '\n';  // Her bir QR verisini yeni bir satırda ekliyoruz.
      });
    }

    return qrData;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generate QR Code'),
      ),
      body: FutureBuilder<String>(
        future: getQrDataFromFirestore(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          return Center(
            child: QrImageView(
              data: snapshot.data!,
              version: QrVersions.auto,
              size: 300.0,
            ),
          );
        },
      ),
    );
  }
}
