import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VendorOrderScreen extends StatefulWidget {
  @override
  _VendorOrderScreenState createState() => _VendorOrderScreenState();
}

class _VendorOrderScreenState extends State<VendorOrderScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vendor Orders'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('orders')
            .where('vendorId', isEqualTo: _auth.currentUser!.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading');
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot document = snapshot.data!.docs[index];
              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
              bool isPickedUp = data['isPickedUp'];
              String statusText = isPickedUp ? 'order delivered.' : 'order not delivered';

              return Card(
                elevation: 2,
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Row(
                    children: [
                      Text('Order ${index + 1}'),
                      SizedBox(width: 8),
                      if (isPickedUp)
                        Icon(
                          Icons.check_circle,
                          color: Colors.green,
                        )
                      else
                        Icon(
                          Icons.close,
                          color: Colors.red,
                        ),
                    ],
                  ),
                  subtitle: Text("${data['fullName']}'s ${statusText} " ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Order Information',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Text('Ordered Customer: ${data['fullName']}'),
                                Text('Phone: ${data['phone']}'),
                                SizedBox(height: 16.0),
                                Text(
                                  'Items:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                for (int i = 0; i < data['items'].length; i++)
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Product ${i + 1}'),
                                      Text('Product Name: ${data['items'][i]['productName']}'),
                                      Text('Quantity: ${data['items'][i]['quantity']}'),
                                      Text('Product Price: ${data['items'][i]['productPrice']}'),
                                      SizedBox(height: 16.0),
                                    ],
                                  ),
                                Text(
                                  'Total Price: \$${data['totalPrice'].toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                                SizedBox(height: 16.0),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    child: Text('OK'),
                                    onPressed: () async {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
