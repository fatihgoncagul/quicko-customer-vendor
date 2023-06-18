import 'package:flutter/material.dart';
import 'package:quicko/vendor/views/screens/edit_product_tabs/published_tab.dart';
import 'package:quicko/vendor/views/screens/edit_product_tabs/unpublished_tab.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(
            'Manage Products',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              letterSpacing: 4,
            ),
          ),
          backgroundColor: Colors.blue,
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text('Published'),
              ),
              Tab(
                child: Text('Unpublished'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            PublishedTab(),
            UnpublishedTab(),
          ],
        ),
      ),
    );
  }
}
