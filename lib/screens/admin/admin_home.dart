import 'package:flutter/material.dart';
import 'package:hunters_group_project/models/person.dart';
import 'package:hunters_group_project/screens/admin_drawer.dart';
import 'package:hunters_group_project/shared/constants.dart';
import 'package:hunters_group_project/shared/functions.dart';

class AdminHomePage extends StatefulWidget {
  final Person person;
  AdminHomePage({this.person});
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdminDrawer(person: widget.person),
      appBar: myAppBar("Home Page", false),
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
                Container(
                  child: Text(
                    "HUNTERS GROUP \ADMIN PAGE",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.cyan[900]),
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
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
                    child: Image.asset('assets/chart3.png'),
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
