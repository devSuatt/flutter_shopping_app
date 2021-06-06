import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:hunters_group_project/models/order.dart';
import 'package:hunters_group_project/models/person.dart';
import 'package:hunters_group_project/screens/customer_drawer.dart';
import 'package:hunters_group_project/services/db_services.dart';
import 'package:hunters_group_project/shared/functions.dart';
import 'package:hunters_group_project/shared/loading.dart';

class OrderList extends StatefulWidget {
  final Person person;
  OrderList({this.person});
  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar("My Orders", false),
      drawer: CustomerDrawer(person: widget.person),
      backgroundColor: Colors.blueGrey[100],
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 15),
            child: StreamBuilder<List<Order>>(
              stream: DatabaseServices(uid: widget.person.personId).orders,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Order> myOrders = snapshot.data;
                  return ListView.builder(
                    itemCount: myOrders.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(7),
                        decoration: boxDecoration(15, Colors.blue),
                        child: ExpansionTile(
                          leading: Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: myOrders[index].status == "ready" ? Icon(Icons.check, color: Colors.green) : Icon(Icons.cancel_outlined, color: Colors.red),
                          ),
                          trailing: Icon(Icons.keyboard_arrow_down),
                          title: Text(myOrders[index].productName),
                          children: [
                            Divider(endIndent: 10, indent: 10, thickness: 1),
                            Text("Order Date: ", style: TextStyle(fontSize: 17, color: Colors.cyan[800])),
                            Text(formatDate(DateTime.parse(myOrders[index].orderDate), [dd, '/', mm, '/', yyyy]),
                                style: TextStyle(fontSize: 17, color: Colors.purple[800])),
                            Divider(endIndent: 10, indent: 10, thickness: 1),
                            Text("Price: ", style: TextStyle(fontSize: 17, color: Colors.cyan[800])),
                            Text(myOrders[index].price, style: TextStyle(fontSize: 17, color: Colors.purple[800])),
                            SizedBox(height: 15),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return Loading();
                }
              },
            ),
          ),
          clipPath(),
        ],
      ),
    );
  }
}
