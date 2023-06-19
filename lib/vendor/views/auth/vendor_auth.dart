import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import '../screens/landing_screen.dart';

class VendorAuthScreen extends StatelessWidget {
  const VendorAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      // If the user is already signed-in, use it as initial data
      initialData: FirebaseAuth.instance.currentUser,
      builder: (context, snapshot) {
        // User is not signed in
        if (!snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text('Vendor'),
            ),
            body: SignInScreen(
              providerConfigs: [
                EmailProviderConfiguration(),
                GoogleProviderConfiguration(
                  clientId: "1:836935690091:android:586b19d467273a30ad4e2e",
                ),
                PhoneProviderConfiguration(),
              ],
            ),
          );
        }

        // Render your application if authenticated
        return LandingScreen(); //landingten sonra hot restart, sonraregisterscreen yapıyoz
      },
    );
  }
}
