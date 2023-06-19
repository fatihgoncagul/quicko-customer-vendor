import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:provider/provider.dart';
import 'package:quicko/provider/cart_provider.dart';
import 'package:quicko/provider/product_provider.dart';
import 'package:quicko/vendor/views/auth/vendor_auth.dart';
import 'package:quicko/vendor/views/screens/landing_screen.dart';
import 'package:quicko/vendor/views/screens/main_vendor_screen.dart';
import 'package:quicko/vendor/views/screens/vendor_logout_screen.dart';
import 'package:quicko/views/customers/auth/register_screen.dart';
import 'package:quicko/views/customers/main_screen.dart';
import 'package:quicko/views/customers/nav_screens/payment/generateQR_screen.dart';

import 'views/customers/auth/login_screen.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) {
        return ProductProvider();
      }),
      ChangeNotifierProvider(create: (_) {
        return CartProvider();
      })
    ],
    child: const MyApp(),
  ));
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text('Customer'),
              onPressed: () {
                Navigator.pushNamed(context, '/login_screen');
              },
            ),
            SizedBox(height: 20), //give some space between two buttons
            ElevatedButton(
              child: Text('Vendor'),
              onPressed: () {
                Navigator.pushNamed(context, '/vendor_auth');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: 'Poppins-Bold',
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MainScreen(),
        '/generateQRScreen': (context) => QRGeneratorScreen(),
        '/login_screen': (context) => LoginScreen(), // Customer's login screen
        '/vendor_auth': (context) => VendorAuthScreen(),

      },
      builder: EasyLoading.init(),
    );
  }
}
