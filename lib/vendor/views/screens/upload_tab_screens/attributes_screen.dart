import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quicko/provider/product_provider.dart';

class AttributesScreen extends StatefulWidget {
  @override
  State<AttributesScreen> createState() => _AttributesScreenState();
}

class _AttributesScreenState extends State<AttributesScreen> with AutomaticKeepAliveClientMixin{


  @override
  Widget build(BuildContext context) {
    final ProductProvider _productProvider =
        Provider.of<ProductProvider>(context);
    return Column(
      children: [
        TextFormField(
          validator: (value){
            if(value!.isEmpty){
              return "Enter product brand";
            }else{
              return null;
            }
          },
          onChanged: (value) {
            _productProvider.getFormData(brandName: value);
          },
          decoration: InputDecoration(labelText: "Brand"),
        ),
        SizedBox(
          height: 10,
        ),
        //size wont be added
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
