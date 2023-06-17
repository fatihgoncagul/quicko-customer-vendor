import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quicko/provider/cart_provider.dart';
import 'package:quicko/views/customers/nav_screens/models/Cart.dart';

import 'components/body.dart';
import 'package:quicko/views/customers/nav_screens/components/check_out.dart';

class CartScreen extends StatelessWidget {
  //static String routeName = "/cart";

  @override
  Widget build(BuildContext context) {
    final CartProvider _cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        elevation: 0,
        title: Text(
          'Cart Screen',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _cartProvider.removeAllItem();
            },
            icon: Icon(
              CupertinoIcons.delete,
              color: Colors.white,
            ),
          ),
        ],
      ),
      bottomSheet: CheckoutCard(),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: _cartProvider.getCartItems.length,
        itemBuilder: (context, index) {
          final cartData = _cartProvider.getCartItems.values.toList()[index];
          return Card(
            child: SizedBox(
              height: 180,
              child: Row(
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.network(cartData.imageUrl[0]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cartData.productName,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '\$' + cartData.price.toStringAsFixed(2),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 14.0),
                          child: Row(
                            children: [
                              Container(
                                height: 40,
                                width: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.blue.shade900,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: cartData.quantity == 1
                                          ? null
                                          : () {
                                              _cartProvider
                                                  .decreament(cartData);
                                            },
                                      icon: Icon(
                                        CupertinoIcons.minus,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      cartData.quantity.toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: cartData.productQuantity ==
                                              cartData.quantity
                                          ? null
                                          : () {
                                              _cartProvider.increment(cartData);
                                            },
                                      icon: Icon(
                                        CupertinoIcons.plus,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  _cartProvider.removeItem(cartData.productId);
                                },
                                icon: Icon(CupertinoIcons.cart_badge_minus),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
