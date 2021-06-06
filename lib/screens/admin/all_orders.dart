import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:hunters_group_project/models/order.dart';
import 'package:hunters_group_project/models/person.dart';
import 'package:hunters_group_project/screens/admin_drawer.dart';
import 'package:hunters_group_project/services/db_services.dart';
import 'package:hunters_group_project/shared/functions.dart';
import 'package:hunters_group_project/shared/loading.dart';

class AllOrders extends StatefulWidget {
  final Person person;
  AllOrders({this.person});
  @override
  _AllOrdersState createState() => _AllOrdersState();
}

class _AllOrdersState extends State<AllOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdminDrawer(),
      appBar: myAppBar("Orders", false),
      backgroundColor: Colors.lightGreen[50],
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 15),
            child: StreamBuilder<List<Order>>(
              stream: DatabaseServices().allOrders ?? [],
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Order> orders = snapshot.data ?? [];
                  return ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      if (orders[index].status == "purchased") {
                        return Container(
                          margin: EdgeInsets.only(top: 4, left: 2, right: 2, bottom: 4),
                          decoration: boxDecoration(20, Colors.lightGreen[200]),
                          child: SingleChildScrollView(
                            physics: ScrollPhysics(),
                            child: ExpansionTile(
                              leading: Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Icon(
                                  Icons.person, /*color: createRandomColor()*/
                                ),
                              ),
                              trailing: Icon(Icons.keyboard_arrow_down),
                              title: Text(
                                orders[index].productName.toUpperCase(),
                                style: TextStyle(fontSize: 20),
                              ),
                              subtitle: Container(
                                padding: EdgeInsets.only(top: 2),
                                child: Text(
                                  "Order Date: " +
                                      formatDate(
                                        DateTime.parse(orders[index].orderDate),
                                        [dd, '/', mm, '/', yyyy],
                                      ),
                                  style: TextStyle(color: Colors.pink[800]),
                                ),
                              ),
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.fromLTRB(20, 3, 3, 3),
                                  child: Text(
                                    "Customer Name: " + orders[index].customerName,
                                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w300),
                                  ),
                                ),
                                Divider(indent: 16, endIndent: 16, thickness: 1),
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.fromLTRB(20, 3, 3, 3),
                                  child: Text(
                                    "Price: " + orders[index].price + " \$",
                                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w300, color: Colors.purple[800]),
                                  ),
                                ),
                                Divider(indent: 16, endIndent: 16, thickness: 1),
                                //curtainsWidgetList(curtains),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  width: 250,
                                  child: FlatButton(
                                    onPressed: () {
                                      showDialogIsOrderReady(context, orders[index]);
                                    },
                                    child: Text("COMPLETE", style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold)),
                                    color: Colors.teal,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return Container(height: 0, width: 0);
                      }
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

  void showDialogIsOrderReady(BuildContext context, Order order) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(
            "Is Order ready?",
            style: TextStyle(color: Theme.of(context).primaryColor),
            textAlign: TextAlign.center,
          ),
          children: [
            Divider(
              indent: 16,
              endIndent: 16,
              thickness: 1,
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(12),
              child: Text("Please do final checks", style: TextStyle(fontSize: 15, color: Colors.pink[800])),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(12, 8, 8, 8),
              child: Text(
                  "After making all the checks and packing the orders, confirm the transaction, otherwise the confirmation process will be irreversible."),
            ),
            SizedBox(height: 10),
            Divider(
              indent: 16,
              endIndent: 16,
              thickness: 1,
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 90,
                  child: RaisedButton(
                    color: Colors.red,
                    child: Text("NO", style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Container(
                  width: 90,
                  child: RaisedButton(
                    color: Colors.green,
                    onPressed: () {
                      DatabaseServices(uid: order.customerId).changeOrdersReadyState(order);
                      Navigator.pop(context);
                    },
                    child: Text("YES", style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

}
