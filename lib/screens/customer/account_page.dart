import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:hunters_group_project/models/order.dart';
import 'package:hunters_group_project/models/person.dart';
import 'package:hunters_group_project/screens/customer_drawer.dart';
import 'package:hunters_group_project/services/db_services.dart';
import 'package:hunters_group_project/shared/functions.dart';
import 'package:hunters_group_project/shared/loading.dart';

List<Order> myOrders = [];

class AccountPage extends StatefulWidget {
  final Person person;
  AccountPage({this.person});
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  int total = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1)).then((_) {
      myOrders.forEach((element) {
        total += int.parse(element.price);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar("My Account", false),
      drawer: CustomerDrawer(person: widget.person),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 25),
            child: StreamBuilder<List<Order>>(
              stream: DatabaseServices(uid: widget.person.personId).orders ?? [],
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  myOrders = List.from(snapshot.data);
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: ScrollPhysics(),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.symmetric(vertical: 20, horizontal: 9),
                          child: Text(
                            "Purchases you have made ever",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: myOrders.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: boxDecoration(1, Colors.blue),
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(7),
                                    child: Text(
                                      formatDate(DateTime.parse(myOrders[index].orderDate), [dd, '/', mm, '/', yyyy]),
                                      style: TextStyle(fontSize: 18, color: Colors.blue[800], fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                  Icon(Icons.arrow_forward_rounded),
                                  Container(
                                    margin: EdgeInsets.all(7),
                                    child: Text(
                                      myOrders[index].price + " \$",
                                      textAlign: TextAlign.end,
                                      style: TextStyle(fontSize: 18, color: Colors.red[900], fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        Container(
                          margin: EdgeInsets.all(15),
                          padding: EdgeInsets.fromLTRB(42, 15, 15, 15),
                          alignment: Alignment.centerLeft,
                          decoration: boxDecoration(10, Colors.green[800]),
                          child: Text(
                            "TOTAL = " + splitWithDot(getTotal(myOrders)) + " \$",
                            style: TextStyle(fontSize: 20, color: Colors.green[900], fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
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

  String getTotal(List<Order> orders) {
    int totalPrice = 0;
    orders.forEach((element) {
      totalPrice += int.parse(element.price);
    });
    return totalPrice.toString();
  }

  String splitWithDot(String text) {
    String newText = "";
    if (text.length > 3) {
      for (int i = 0; i < text.length - 3; i++) {
        newText += text[i];
      }
      newText += ".";
      for (int i = text.length - 3; i < text.length; i++) {
        newText += text[i];
      }
      return newText;
    }
    return text;
  }
}
