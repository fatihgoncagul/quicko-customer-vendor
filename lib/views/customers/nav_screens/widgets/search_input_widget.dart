import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchInputWidget extends StatefulWidget {
  const SearchInputWidget({
    super.key,
  });

  @override
  State<SearchInputWidget> createState() => _SearchInputWidgetState();
}

class _SearchInputWidgetState extends State<SearchInputWidget> {
  Future<QuerySnapshot>? searchDocumentList;
  String productNameText = '';

  initSearching(String textEntered) {
    searchDocumentList = FirebaseFirestore.instance
        .collection('products')
        .where('productName', isGreaterThanOrEqualTo: textEntered)
        .get();

    setState(() {
      searchDocumentList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: TextField(
          onChanged: (textEntered) {
            setState(() {
              productNameText = textEntered;
            });
            initSearching(textEntered);
          },
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: 'Search for Ordering',
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            suffixIcon: IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
              onPressed: () {
                initSearching(productNameText);
              },
            ),
          ),
        ),
      ),
    );
  }
}
