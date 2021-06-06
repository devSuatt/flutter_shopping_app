import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hunters_group_project/models/person.dart';
import 'package:hunters_group_project/screens/admin/admin_home.dart';
import 'package:hunters_group_project/screens/admin/all_orders.dart';
import 'package:hunters_group_project/screens/admin/customer_list.dart';
import 'package:hunters_group_project/screens/admin/product_list.dart';
import 'package:hunters_group_project/screens/profile.dart';
import 'package:hunters_group_project/shared/constants.dart';
import 'package:hunters_group_project/shared/functions.dart';

class AdminDrawer extends StatefulWidget {
  final Person person;
  AdminDrawer({this.person});
  @override
  _AdminDrawerState createState() => _AdminDrawerState();
}

class _AdminDrawerState extends State<AdminDrawer> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      child: ClipPath(
        /// Building Shape for drawer .
        clipper: OvalRightBorderClipper(),

        /// Building drawer widget .
        child: Drawer(
          child: Container(
            padding: const EdgeInsets.only(left: 16.0, right: 40),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  drawerBackgroundColor,
                  Colors.grey[700],
                ],
                begin: Alignment.center,
                end: Alignment.bottomCenter,
              ),
            ),
            width: 300,
            child: SafeArea(
              /// Building scrolling  content for drawer .
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10),
                    logo(60),
                    SizedBox(height: 5.0),

                    /// Building header title for drawer .
                    Text(
                      "HUNTERS GROUP\nCONTROL PANEL",
                      style: TextStyle(color: Colors.grey.shade200, fontSize: 17.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),

                    /// Building items list  for drawer .
                    SizedBox(height: 20.0),
                    _buildRow(
                      Icons.home_outlined,
                      Colors.blue[50],
                      "Home Page",
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminHomePage(person: widget.person)));
                      },
                    ),
                    _buildDivider(3),
                    _buildRow(
                      Icons.shopping_cart_outlined,
                      Colors.cyan[300],
                      'Orders',
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AllOrders(person: widget.person)));
                      },
                    ),
                    _buildDivider(1),
                    _buildRow(
                      Icons.shopping_bag_outlined,
                      Colors.orange[600],
                      'Products',
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductList(person: widget.person)));
                      },
                    ),
                    _buildDivider(0),
                    _buildRow(
                      Icons.contacts,
                      Colors.orange[200],
                      'Customers',
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CustomerList(person: widget.person)));
                      },
                    ),
                    _buildDivider(0),
                    _buildRow(
                      Icons.person_outline,
                      Colors.white,
                      "My Profile",
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(person: widget.person)));
                      },
                    ),
                    SizedBox(height: 175),
                    _buildDivider(27),
                    _buildRow(
                      Icons.exit_to_app,
                      Colors.red,
                      "Log Out",
                      onTap: () {
                        logOut(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Divider _buildDivider(double endIndent) {
    return Divider(
      endIndent: endIndent,
      color: Colors.grey.shade300,
    );
  }

  Widget _buildRow(IconData icon, Color iconColor, String title, {GestureTapCallback onTap}) {
    final TextStyle tStyle = TextStyle(color: Colors.blue.shade50, fontSize: 16.0);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Padding(
        padding: const EdgeInsets.only(right: 5.0),
        child: GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              Icon(
                icon,
                color: iconColor,
              ),
              SizedBox(width: 10.0),
              Text(
                title,
                style: tStyle,
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createDrawerItem({IconData icon, String text, GestureTapCallback onTap, Color itemColor}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(
            icon,
            color: itemColor,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}

class OvalRightBorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(size.width - 40, 0);
    path.quadraticBezierTo(size.width, size.height / 4, size.width, size.height / 2);
    path.quadraticBezierTo(size.width, size.height - (size.height / 4), size.width - 40, size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
