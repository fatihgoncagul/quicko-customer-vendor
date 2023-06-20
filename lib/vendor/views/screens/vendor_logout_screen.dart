import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VendorLogoutScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () async {
          await _auth.signOut();
        },
        style: TextButton.styleFrom(
          backgroundColor: Colors.blue, // Arka plan rengi burada belirlenir
        ),
        child: Text("Vendor Logout Screen",style: TextStyle(color: Colors.white),),
      ),
    );
  }
}
