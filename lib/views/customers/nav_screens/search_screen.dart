import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quicko/views/customers/productDetail/product_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _searchedValue = '';

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productStream =
        FirebaseFirestore.instance.collection('products').snapshots();
    final Stream<QuerySnapshot> _vendorsStream =
        FirebaseFirestore.instance.collection('vendors').snapshots();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        elevation: 0,
        title: TextFormField(
          onChanged: (value) {
            setState(() {
              _searchedValue = value;
            });
          },
          decoration: InputDecoration(
            labelText: 'Search for Products',
            labelStyle: TextStyle(
              color: Colors.white,
              letterSpacing: 2,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: _searchedValue == ''
          ? Center(
              child: Text(
                'Search For Products',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : StreamBuilder<QuerySnapshot>(
              stream: _productStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> productSnapshot) {
                if (productSnapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (productSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Text("Loading");
                }

                final searchedData =
                    productSnapshot.data!.docs.where((element) {
                  return element['productName']
                      .toLowerCase()
                      .contains(_searchedValue.toLowerCase());
                });

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: searchedData.length,
                        itemBuilder: (context, index) {
                          final e = searchedData.elementAt(index);
                          return FutureBuilder<QuerySnapshot>(
                            future: FirebaseFirestore.instance
                                .collection('vendors')
                                .where('vendorId', isEqualTo: e['vendorId'])
                                .get(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> vendorSnapshot) {
                              if (vendorSnapshot.hasError) {
                                return Text('Something went wrong');
                              }

                              if (vendorSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              }

                              final vendorData =
                                  vendorSnapshot.data!.docs.first;

                              return GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return ProductDetailScreen(
                                        productData: e,
                                      );
                                    }));
                                  },
                                  child: Card(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.blue.shade300,
                                            Colors.blue.shade900
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            height: 100,
                                            width: 100,
                                            child: Image.network(
                                                e['imageUrlList'][0]),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  e['productName'],
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  e['productPrice']
                                                      .toStringAsFixed(2),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                FutureBuilder<QuerySnapshot>(
                                                  future: FirebaseFirestore
                                                      .instance
                                                      .collection('vendors')
                                                      .where('vendorId',
                                                          isEqualTo:
                                                              e['vendorId'])
                                                      .get(),
                                                  builder:
                                                      (BuildContext context,
                                                          AsyncSnapshot<
                                                                  QuerySnapshot>
                                                              vendorSnapshot) {
                                                    if (vendorSnapshot
                                                        .hasError) {
                                                      return Text(
                                                          'Something went wrong');
                                                    }

                                                    if (vendorSnapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return CircularProgressIndicator();
                                                    }

                                                    final vendorData =
                                                        vendorSnapshot
                                                            .data!.docs.first;

                                                    return Text(
                                                      vendorData[
                                                          'businessName'],
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    );
                                                  },
                                                ),
                                                FutureBuilder<QuerySnapshot>(
                                                  future: FirebaseFirestore
                                                      .instance
                                                      .collection('products')
                                                      .where('productName',
                                                          isEqualTo:
                                                              e['productName'])
                                                      .get(),
                                                  builder: (BuildContext
                                                          context,
                                                      AsyncSnapshot<
                                                              QuerySnapshot>
                                                          categorySnapshot) {
                                                    if (categorySnapshot
                                                        .hasError) {
                                                      return Text(
                                                          'Something went wrong');
                                                    }

                                                    if (categorySnapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return CircularProgressIndicator();
                                                    }

                                                    final categoryData =
                                                        categorySnapshot
                                                            .data!.docs.first;

                                                    return Text(
                                                      categoryData['category'],
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ));
                            },
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
