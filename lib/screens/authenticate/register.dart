import 'package:flutter/material.dart';
import 'package:hunters_group_project/services/auth_services.dart';
import 'package:hunters_group_project/shared/constants.dart';
import 'package:hunters_group_project/shared/functions.dart';
import 'package:hunters_group_project/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthServices auth = AuthServices();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String name = "";
  String email = "";
  String address = "";
  String password = "";
  String errorText = "";

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              elevation: 0,
              backgroundColor: drawerBackgroundColor,
              title: Text("Register Page", style: TextStyle(color: Colors.white)),
              actions: [
                FlatButton.icon(
                  onPressed: () {
                    widget.toggleView();
                    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Authenticate()));
                  },
                  icon: Icon(Icons.person, color: Colors.white),
                  label: Text("Login", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            body: Container(
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    drawerBackgroundColor,
                    Colors.grey,
                  ],
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    SizedBox(height: 10),
                    logo(70),
                    SizedBox(height: 10),
                    Text(
                      "HUNTERS GROUP",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 15),
                    Container(
                      height: 50,
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() => name = value);
                        },
                        obscureText: false,
                        validator: (val) => val.isEmpty ? "enter your name" : null,
                        decoration: textInputDecoration("your name", "Name", Icon(Icons.person_outline)),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 50,
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() => email = value);
                        },
                        obscureText: false,
                        validator: (val) => val.isEmpty ? "enter email address" : null,
                        decoration: textInputDecoration("your email address", "Email", Icon(Icons.mail_outline)),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 50,
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() => address = value);
                        },
                        obscureText: false,
                        validator: (val) => val.isEmpty ? "enter your address" : null,
                        decoration: textInputDecoration("your address", "Address", Icon(Icons.home_outlined)),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 50,
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() => password = value);
                        },
                        validator: (val) => val.isEmpty ? "enter password" : null,
                        obscureText: true,
                        decoration: textInputDecoration("your password", "Password", Icon(Icons.lock_outline)),
                      ),
                    ),
                    SizedBox(height: 10),
                    RaisedButton(
                      color: Colors.blue.shade700,
                      child: Text(
                        "Register",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          dynamic result = await auth.registerWithEmailAndPassword(name, email, address, password);
                          if (result == null) {
                            setState(() {
                              errorText = "please suply a valid email";
                              loading = false;
                            });
                          } else {}
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
