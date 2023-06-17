import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quicko/provider/product_provider.dart';
import 'package:quicko/vendor/views/screens/upload_tab_screens/%C4%B1mages_screen.dart';
import 'package:quicko/vendor/views/screens/upload_tab_screens/attributes_screen.dart';
import 'package:quicko/vendor/views/screens/upload_tab_screens/general_screen.dart';
import 'package:quicko/vendor/views/screens/upload_tab_screens/shipping_screen.dart';
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
                child: Text('Shipping'),
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
              ShippingScreen(),
              AttributesScreen(),
              ImagesScreen(),
            ],
          ),
          bottomSheet: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(style:
              ElevatedButton.styleFrom(primary: Colors.yellow.shade900),onPressed: ()async{
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
              });
            }


            },child:Text("Save") ,),
          ),
        ),
      ),
    );
  }
}