import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quicko/views/customers/nav_screens/account_screen.dart';
import 'package:quicko/views/customers/nav_screens/cart_screen.dart';
import 'package:quicko/views/customers/nav_screens/home_screen.dart';
import 'package:quicko/views/customers/nav_screens/search_screen.dart';
import 'package:quicko/views/customers/nav_screens/store_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _pageIndex =0;
  List<Widget> _pages =[
    HomeScreen(),
    StoreScreen(),
    CartScreen(),
    AccountsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type:BottomNavigationBarType.fixed ,
        currentIndex: _pageIndex,
        onTap: (value){
          setState(() {
            _pageIndex = value;
          });
        },
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.blue,
        items: [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              label: 'HOME'),

          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/shop.svg',
                width: 20,
              ),
              label: 'STORE'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/cart.svg',
                width: 20,
              ),
              label: 'CART'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/account.svg',
                width: 20,
              ),
              label: 'PROFILE'),
        ],
      ),
      body: _pages[_pageIndex],
    );
  }
}
