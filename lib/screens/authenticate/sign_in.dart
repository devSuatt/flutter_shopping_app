import 'package:flutter/material.dart';
import 'package:hunters_group_project/services/auth_services.dart';
import 'package:hunters_group_project/shared/constants.dart';
import 'package:hunters_group_project/shared/functions.dart';
import 'package:hunters_group_project/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthServices auth = AuthServices();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String email = "";
  String password = "";
  String errorText = "";

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: drawerBackgroundColor,
              title: Text("Login Page", style: TextStyle(color: Colors.white)),
              actions: [
                FlatButton.icon(
                  onPressed: () {
                    widget.toggleView();
                    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Authenticate()));
                  },
                  icon: Icon(Icons.person, color: Colors.white),
                  label: Text("Register", style: TextStyle(color: Colors.white)),
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
                    SizedBox(height: 20),
                    logo(70),
                    SizedBox(height: 10),
                    Text(
                      "HUNTERS GROUP",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 25),
                    errorText == ""
                        ? Container()
                        : Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(bottom: 5),
                            child: Text(
                              "Email or password is false",
                              style: TextStyle(color: Colors.red[800], fontSize: 16),
                            ),
                          ),
                    Container(
                      height: 50,
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() => email = value);
                        },
                        obscureText: false,
                        validator: (val) => val.isEmpty ? "Enter an email" : null,
                        decoration: textInputDecoration("your email address", "Email", Icon(Icons.mail)),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 50,
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() => password = value);
                        },
                        obscureText: true,
                        validator: (val) => val.isEmpty ? "Enter a password" : null,
                        decoration: textInputDecoration("your password", "Password", Icon(Icons.lock)),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 120,
                      child: RaisedButton(
                        color: Colors.blue[700],
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            dynamic result = await auth.signInWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                errorText = "sign in error with those credentials";
                                loading = false;
                              });
                            } else {
                              print("login is successful");
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
