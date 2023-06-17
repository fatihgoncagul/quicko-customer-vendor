import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:quicko/provider/product_provider.dart';
import 'package:quicko/vendor/views/auth/vendor_auth.dart';
import 'package:quicko/vendor/views/auth/vendor_registor.dart';
import 'package:quicko/vendor/views/screens/landing_screen.dart';
import 'package:quicko/vendor/views/screens/main_vendor_screen.dart';
import 'package:quicko/views/customers/auth/login_screen.dart';
import 'package:quicko/views/customers/auth/register_screen.dart';
import 'package:quicko/views/customers/main_screen.dart';
import 'package:quicko/views/customers/nav_screens/home_screen.dart';
import 'package:quicko/views/customers/nav_screens/payment/generateQR_screen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_){
      return ProductProvider();
    })
  ],
  child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: 'Poppins-Bold',
        useMaterial3: true,
      ),
      initialRoute: '/', // optional if your initial screen is LoginScreen
      routes: {
        '/': (context) => CustomerRegisterScreen(), // optional if your initial screen is LoginScreen
        '/generateQRScreen': (context) => GenerateQRScreen(),
      },
      builder: EasyLoading.init(),
    );
  }
}
