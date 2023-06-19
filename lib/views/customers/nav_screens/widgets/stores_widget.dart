import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quicko/views/customers/nav_screens/widgets/home_products.dart';
import 'package:quicko/views/customers/nav_screens/widgets/main_products_widget.dart';
import 'package:quicko/views/customers/productDetail/store_detail.dart';

class StoreText extends StatefulWidget {
  @override
  State<StoreText> createState() => _StoreTextState();
}

class _StoreTextState extends State<StoreText> {


  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _storeStream =
    FirebaseFirestore.instance.collection('vendors').snapshots();
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Stores',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _storeStream,
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                );
              }

              return Container(
                height: snapshot.data!.size * 100.0,
                child: ListView.builder(
                    itemCount: snapshot.data!.size,
                    itemBuilder: (context, index) {
                      final storeData = snapshot.data!.docs[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                return StoreDetailScreen(
                                  storeData: storeData,
                                );
                              }));
                        },
                        child: ListTile(
                          title: Text(storeData['businessName']),
                          subtitle: Text(storeData['cityValue']),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(storeData['storeImage']),
                          ),
                        ),
                      );
                    }),
              );
            },
          ),
        ],
      ),
    );
  }
}
