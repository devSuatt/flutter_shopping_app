import 'package:flutter/material.dart';

class Product {

  final String productId;
  final String productName;
  final String productDescription;
  final String imageUrl;
  final int rating;
  final String productCode;
  final String productUnit;
  final String unitPrice;
  final bool hasStock;

  Product({@required this.productId, this.productName, this.productDescription, this.imageUrl, this.rating,this.productCode, this.productUnit, this.unitPrice, this.hasStock});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product (
      productId: json['productId'],
      productName: json['productName'],
      productDescription: json['productDescription'],
      imageUrl: json['imageUrl'],
      rating: json['rating'],
      productCode: json['productCode'],
      productUnit: json['productUnit'],
      unitPrice: json['unitPrice'],
      hasStock: json['hasStock'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'productDescription': productDescription,
      'imageUrl': imageUrl,
      'rating': rating,
      'productCode': productCode,
      'productUnit': productUnit,
      'unitPrice': unitPrice,
      'hasStock': hasStock,
    };
  }

}
