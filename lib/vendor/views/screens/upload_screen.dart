import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:quicko/provider/product_provider.dart';
import 'package:quicko/vendor/views/screens/main_vendor_screen.dart';
import 'package:quicko/vendor/views/screens/upload_tab_screens/%C4%B1mages_screen.dart';
import 'package:quicko/vendor/views/screens/upload_tab_screens/attributes_screen.dart';
import 'package:quicko/vendor/views/screens/upload_tab_screens/general_screen.dart';
import 'package:uuid/uuid.dart';

class UploadScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    final ProductProvider _productProvider = Provider.of<ProductProvider>(context);
    return DefaultTabController(

      length: 4,
      child: Form(
        key: _formKey,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            elevation: 0,
            bottom:TabBar(tabs: [
              Tab(
                child: Text('General'),
              ),
              Tab(
                child: Text('Attributes'),
              ),
              Tab(
                child: Text('Images'),
              ),
            ],
            ) ,
          ),
          body: TabBarView(
            children: [
              GeneralScreen(),
              AttributesScreen(),
              ImagesScreen(),
            ],
          ),
          bottomSheet: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(style:
              ElevatedButton.styleFrom(primary: Colors.yellow.shade900),
              onPressed: ()async{
              EasyLoading.show(status: 'Please Wait');
              if(_formKey.currentState!.validate()){
              final productId = Uuid().v4();
              await _firestore.collection("products").doc(productId).set({
                "productId": productId,
                "productName": _productProvider.productData["productName"],
                "productPrice": _productProvider.productData["productPrice"],
                "productQuantity": _productProvider.productData["productQuantity"],
                "category": _productProvider.productData["category"],
                "description": _productProvider.productData["description"],
                "imageUrlList": _productProvider.productData["imageUrlList"],
                "imageUrlList": _productProvider.productData["imageUrlList"],
                "brandName": _productProvider.productData["brandName"],
                "vendorId": FirebaseAuth.instance.currentUser!.uid,
              }).whenComplete((){
                _productProvider.clearData();
                _formKey.currentState!.reset();
                EasyLoading.dismiss();
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return MainVendorScreen();
                }));
              });
            }
            },child:Text("Save") ,),
          ),
        ),
      ),
    );
  }
}