import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quicko/vendor/views/screens/edit_product_screen.dart';
import 'package:quicko/vendor/views/screens/scan_screen.dart';
import 'package:quicko/vendor/views/screens/upload_screen.dart';
import 'package:quicko/vendor/views/screens/vendor_logout_screen.dart';
import 'package:quicko/vendor/views/screens/vendor_order_screen.dart';

class MainVendorScreen extends StatefulWidget {
  const MainVendorScreen({Key? key}) : super(key: key);

  @override
  State<MainVendorScreen> createState() => _MainVendorScreenState();
}

class _MainVendorScreenState extends State<MainVendorScreen> {
  int _pageIndex = 0;

  List<Widget> _pages = [
    UploadScreen(),
    EditProductScreen(),
    VendorOrderScreen(),
    VendorLogoutScreen()
  ];

  void _selectPage(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return ScanScreen();
          }));
        },
        child: Icon(Icons.scanner),
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
        elevation: 4,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.blue.shade500),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: _selectPage,
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.upload),
            ),
            label: 'Upload',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.edit),
            ),
            label: 'Edits',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(CupertinoIcons.shopping_cart),
            ),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.logout),
            ),
            label: 'Log out',
          ),
        ],
      ),
      body: _pages[_pageIndex],
    );
  }
}
