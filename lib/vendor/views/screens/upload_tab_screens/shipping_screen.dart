import 'package:flutter/material.dart';

class ShippingScreen extends StatefulWidget {
  const ShippingScreen({Key? key}) : super(key: key);

  @override
  State<ShippingScreen> createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('ShippingScreen'),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
