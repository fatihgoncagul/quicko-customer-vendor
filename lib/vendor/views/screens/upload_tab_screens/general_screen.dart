import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GeneralScreen extends StatefulWidget {

  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final List<String> _categoryList =[];

  _getCategories(){
    return _firestore
        .collection('categories')
        .get()
        .then((QuerySnapshot querySnapshot){
      querySnapshot.docs.forEach((doc) {
        setState(() {
          _categoryList.add(doc['categoryName']);
        });
      });
    });
  }
  @override
  void initState() {
    _getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText:'Enter product name',
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                decoration: InputDecoration(
                  labelText:'Enter product price',
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                decoration: InputDecoration(
                  labelText:'Enter product quanity',
                ),
              ),
              SizedBox(height: 20,),
              DropdownButtonFormField(
                  hint:Text('Select Category') ,
                  items: _categoryList.map<DropdownMenuItem<String>>((e){
                    return DropdownMenuItem(value: e,child: Text(e));
                  }).toList(),
                  onChanged: (value){

                  }
              ),
              SizedBox(height: 20,),
              TextFormField(
                maxLines: 10,
                maxLength: 200,
                decoration: InputDecoration(
                  labelText:('Enter product description'),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
