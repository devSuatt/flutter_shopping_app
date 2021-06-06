import 'package:flutter/material.dart';
import 'package:hunters_group_project/models/person.dart';
import 'package:hunters_group_project/screens/admin_drawer.dart';
import 'package:hunters_group_project/screens/customer_drawer.dart';
import 'package:hunters_group_project/shared/constants.dart';
import 'package:hunters_group_project/shared/functions.dart';

class CustomerHomePage extends StatefulWidget {
  Person person;
  CustomerHomePage({this.person});
  @override
  _CustomerHomePageState createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomerDrawer(person: widget.person),
      appBar: myAppBar("Home Page", false),
      backgroundColor: Colors.grey[200],
      body: Stack(
        children: [
          Container(
            child: ListView(
              children: [
                SizedBox(height: 40),
                Center(
                  child: Container(
                    width: 120,
                    decoration: boxDecoration(65, Colors.blue[700]),
                    child: logo(120),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    "HUNTERS GROUP \nCUSTOMER PAGE",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.cyan[900]),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  height: 200,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.center,
                  decoration: boxDecoration(5, Colors.cyan[900]),
                  child: SizedBox(
                    height: 180,
                    width: 300,
                    child: Image.asset('assets/chart1.png'),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  height: 200,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.center,
                  decoration: boxDecoration(5, Colors.cyan[900]),
                  child: SizedBox(
                    height: 180,
                    width: 300,
                    child: Image.asset('assets/chart2.png'),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
          clipPath(),
        ],
      ),
    );
  }
}
