import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hunters_group_project/screens/authentication.dart';
import 'package:hunters_group_project/shared/border_clipper.dart';
import 'constants.dart';

InputDecoration textInputDecoration(String hint, String label, Icon icon) {
  return InputDecoration(
    enabledBorder: inputBorder,
    disabledBorder: inputBorder,
    focusedBorder: inputBorder,
    prefixIcon: icon,
    hintText: hint,
    labelText: label,
    filled: true,
    fillColor: Colors.white,
    focusColor: Colors.white,
    hoverColor: Colors.white,
    border: OutlineInputBorder(),
  );
}

InputDecoration orderInputDecoration(String hint, String label) {
  return InputDecoration(
    enabledBorder: orderInputBorder,
    disabledBorder: orderInputBorder,
    focusedBorder: orderInputBorder,
    errorBorder: orderInputBorder,
    focusedErrorBorder: orderInputBorder,
    hintText: hint,
    labelText: label,
    filled: true,
    fillColor: Colors.white,
    focusColor: Colors.white,
    hoverColor: Colors.white,
    border: OutlineInputBorder(),
  );
}

ButtonStyle purchaseButtonStyle(Color backgroundColor, Color foregroundColor, Color borderColor) {
  return ButtonStyle(
    padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
    backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
    foregroundColor: MaterialStateProperty.all<Color>(foregroundColor),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0), side: BorderSide(color: borderColor)),
    ),
  );
}

Widget boxTemplate(String text1, String text2) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    margin: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
    decoration: boxDecoration(25, Colors.blue),
    child: Column(
      children: [
        Text(text1, style: TextStyle(color: Colors.blue[800], fontSize: 17)),
        Text(text2, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w300)),
      ],
    ),
  );
}

Widget purchaseBoxTemplate(String text1, String text2) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    margin: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
    decoration: boxDecoration(10, Colors.blue),
    child: Column(
      children: [
        Text(text1, style: TextStyle(color: Colors.blue[800], fontSize: 17)),
        Text(text2, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w300)),
      ],
    ),
  );
}

Widget myAppBar(String title, bool action, {GestureTapCallback onTap, IconData myIcon}) {
  return AppBar(
    elevation: 0,
    backgroundColor: drawerBackgroundColor,
    leading: Builder(
      builder: (BuildContext context) {
        return Container(
          margin: EdgeInsets.only(top: 15),
          child: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          ),
        );
      },
    ),
    title: Container(
      margin: EdgeInsets.only(right: 70),
      child: Center(child: Text(title)),
    ),
    actions: [
      action
          ? Container(
              margin: EdgeInsets.only(right: 15),
              child: CircleAvatar(
                backgroundColor: Colors.blue[50],
                child: IconButton(
                  onPressed: onTap,
                  icon: Icon(
                    myIcon,
                    size: 25,
                    color: Colors.blue[900],
                  ),
                ),
              ),
            )
          : Container(),
    ],
  );
}

Widget inputBoxes(TextInputType inputType, Function onChanged, TextEditingController controller, String labelText, int maxLines) {
  return Padding(
    padding: EdgeInsets.all(8),
    child: TextField(
      keyboardType: inputType,
      onChanged: (String value) {
        onChanged(value);
      },
      controller: controller,
      style: TextStyle(fontSize: 16),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: labelText,
        border: OutlineInputBorder(),
      ),
      maxLines: maxLines,
    ),
  );
}

Future logOut(BuildContext context) async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  return showDialog(
    context: context,
    builder: (context) {
      return SimpleDialog(
        title: Text(
          "Are you sure\n you want to log out?",
          style: TextStyle(color: Theme.of(context).primaryColor),
          textAlign: TextAlign.center,
        ),
        children: [
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.red.shade700,
                child: Text(
                  "No",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              RaisedButton(
                onPressed: () async {
                  await _auth.signOut();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Authentication()));
                },
                color: Colors.green.shade700,
                child: Text(
                  "Yes",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}

Widget clipPath() {
  return ClipPath(
    clipper: OvalBottomBorderClipper(),
    child: Container(
      color: drawerBackgroundColor,
      height: 50,
    ),
  );
}

Widget logo(double size) {
  return Container(
    height: size,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.grey[50],
    ),
    child: SizedBox(
      height: size,
      width: size,
      child: Image.asset('assets/logo.png'),
    ),
  );
}

BoxDecoration boxDecoration(double radius, Color borderColor) {
  return BoxDecoration(
    color: Colors.white,
    border: Border.all(color: borderColor, width: 0.5),
    borderRadius: BorderRadius.all(Radius.circular(radius)),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 1,
        blurRadius: 3,
        offset: Offset(0, 2), // changes position of shadow
      ),
    ],
  );
}
