import 'package:flutter/material.dart';

class Order {
  String orderId;
  final String customerId;
  final String customerName;
  final String productName;
  final String productId;
  final String price;
  final String orderDate;
  final String status;

  Order({@required this.orderId, this.price, this.customerName, this.customerId, this.productName, this.productId, this.orderDate, this.status});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
        orderId: json['orderId'],
        customerId: json['customerId'],
        customerName: json['customerName'],
        productName: json['productName'],
        productId: json['productId'],
        price: json['price'],
        orderDate: json['orderDate'],
        status: json['status']);
  }

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'customerId': customerId,
      'customerName': customerName,
      'productName': productName,
      'productId': productId,
      'price': price,
      'orderDate': orderDate,
      'status': status,
    };
  }
}

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
  }

}
