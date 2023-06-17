import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier{
  Map<String, dynamic> productData = {};

  getFormData({String? productName, double? productPrice,int? productQuantity,
    String? category,String? description,List<String>? imageUrlList,
  String? brandName}){
    if(productName != null){
      productData ["productName"] = productName;
    }
    if(productPrice!=null){
      productData ["productPrice"] = productPrice;

    }    if(productQuantity!=null){
      productData ["productQuantity"] = productQuantity;

    }if(category!=null){
      productData ["category"] = category;

    }if(description!=null){
      productData ["description"] = description;

    }if(imageUrlList!=null){
      productData ["imageUrlList"] = imageUrlList;

    }if(brandName!=null){
      productData ["brandName"] = brandName;
    }
    notifyListeners();
  }
  clearData(){
    productData.clear();
    notifyListeners();
  }
}