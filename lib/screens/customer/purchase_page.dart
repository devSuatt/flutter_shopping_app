import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:hunters_group_project/models/order.dart';
import 'package:hunters_group_project/models/person.dart';
import 'package:hunters_group_project/screens/customer/customer_home.dart';
import 'package:hunters_group_project/screens/customer/order_list.dart';
import 'package:hunters_group_project/screens/customer_drawer.dart';
import 'package:hunters_group_project/shared/constants.dart';
import 'package:hunters_group_project/shared/functions.dart';
import 'package:hunters_group_project/shared/loading.dart';

class PurchasePage extends StatefulWidget {
  final Order order;
  final Person person;
  PurchasePage({this.order, this.person});
  @override
  _PurchasePageState createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomerDrawer(person: widget.person),
      appBar: myAppBar("Purchase Product", false),
      body: Stack(
        children: [
          ListView(
            children: [
              SizedBox(height: 40),
              Container(
                decoration: boxDecoration(10, Colors.green[700]),
                padding: EdgeInsets.symmetric(vertical: 15),
                margin: EdgeInsets.symmetric(horizontal: 22, vertical: 20),
                alignment: Alignment.topLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 15),
                      child: Text("Product Name: ", style: TextStyle(color: Colors.green[700], fontSize: 18)),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 15),
                      child: Text(widget.order.productName, style: TextStyle(color: Colors.black, fontSize: 18)),
                    ),
                    Divider(indent: 16, endIndent: 16, thickness: 1),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 15),
                      child: Text("Customer Name: ", style: TextStyle(color: Colors.green[700], fontSize: 18)),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      alignment: Alignment.centerLeft,
                      child: Text(widget.order.customerName, style: TextStyle(color: Colors.black, fontSize: 18)),
                    ),
                    Divider(indent: 16, endIndent: 16, thickness: 1),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 15),
                      child: Text("Order Date: ", style: TextStyle(color: Colors.green[700], fontSize: 18)),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 15),
                      child: Text(formatDate(DateTime.parse(widget.order.orderDate), [dd, '/', mm, '/', yyyy]),
                          style: TextStyle(color: Colors.black, fontSize: 18)),
                    ),
                    Divider(indent: 16, endIndent: 16, thickness: 1),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 15),
                      child: Text("Price: ", style: TextStyle(color: Colors.green[700], fontSize: 18)),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 15),
                      child: Text(widget.order.price + " \$", style: TextStyle(color: Colors.black, fontSize: 18)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Container(
                width: 70,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 22),
                  child: ElevatedButton(
                    style: purchaseButtonStyle(Colors.green[700], Colors.red, Colors.white),
                    child: Text("PAYMENT", style: TextStyle(fontSize: 20, color: Colors.white)),
                    onPressed: () {
                      showSettingsPanel(context, widget.order);
                    },
                  ),
                ),
              ),
            ],
          ),
          clipPath(),
        ],
      ),
    );
  }

  void showSettingsPanel(BuildContext context, Order order) {
    showModalBottomSheet(
      backgroundColor: drawerBackgroundColor,
      isScrollControlled: true,
      isDismissible: true,
      context: context,
      builder: (context) {
        return Container(
          height: 230,
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                alignment: Alignment.topLeft,
                child: Text("Google Play", style: TextStyle(color: Colors.white)),
              ),
              Divider(thickness: 0.5, color: Colors.grey[400], indent: 10, endIndent: 10),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    Text("Make Payment", style: TextStyle(color: Colors.white)),
                    Text(order.price),
                  ],
                ),
              ),
              Divider(thickness: 0.5, color: Colors.grey[400], indent: 10, endIndent: 10),
              Container(
                alignment: Alignment.topLeft,
                child: ListTile(
                  leading: Icon(Icons.album_outlined, color: Colors.white),
                  trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.white),
                  title: Text("VISA CARD", style: TextStyle(color: Colors.white)),
                ),
              ),
              GestureDetector(
                onTap: () {
                  showDialogLoading(context);
                  Future.delayed(Duration(seconds: 3)).then((_) {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OrderList(person: widget.person)));
                  });
                },
                child: Container(
                  padding: EdgeInsets.only(top: 10),
                  height: 47,
                  width: double.infinity,
                  color: Colors.green[700],
                  child: Text(
                    "MAKE PAYMENT",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  showDialogLoading(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text("your transaction is in progress..."),
          backgroundColor: drawerBackgroundColor,
          children: [
            Loading(),
          ],
        );
      },
    );
  }
}
