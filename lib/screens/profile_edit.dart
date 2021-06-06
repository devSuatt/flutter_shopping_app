import 'package:flutter/material.dart';
import 'package:hunters_group_project/models/person.dart';
import 'package:hunters_group_project/providers/person_provider.dart';
import 'package:hunters_group_project/services/db_services.dart';
import 'package:hunters_group_project/shared/constants.dart';
import 'package:hunters_group_project/shared/functions.dart';
import 'package:hunters_group_project/shared/loading.dart';
import 'package:provider/provider.dart';

class ProfileEditPage extends StatefulWidget {
  final Person person;
  ProfileEditPage({this.person});
  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final passwordController = TextEditingController();
  PersonProvider personProvider;

  @override
  void initState() {
    super.initState();
    personProvider = Provider.of<PersonProvider>(context, listen: false);
    if (widget.person != null) {
      userNameController.text = widget.person.userName;
      emailController.text = widget.person.email;
      addressController.text = widget.person.address;
      passwordController.text = widget.person.password;
      personProvider.loadAllPersons(widget.person);
    } else {
      personProvider.loadAllPersons(null);
    }
  }

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: drawerBackgroundColor,
        title: Text("EDIT PROFILE"),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 15),
            child: CircleAvatar(
              backgroundColor: Colors.blue[50],
              child: IconButton(
                onPressed: () {
                  personProvider.savePerson();
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.save_outlined,
                  size: 25,
                  color: Colors.blue[900],
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          StreamBuilder(
            stream: DatabaseServices(uid: widget.person.personId).userData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Person person = snapshot.data;
                return Container(
                  child: Center(
                    child: ListView(children: <Widget>[
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          initialValue: person.userName,
                          keyboardType: TextInputType.text,
                          onChanged: (String value) {
                            personProvider.changeUserName = value;
                          },
                          style: TextStyle(fontSize: 19),
                          decoration: orderInputDecoration("username", "username"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          initialValue: person.email,
                          keyboardType: TextInputType.text,
                          onChanged: (String value) {
                            personProvider.changeEmail = value;
                          },
                          style: TextStyle(fontSize: 19),
                          decoration: orderInputDecoration("email", "email"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          initialValue: person.address,
                          keyboardType: TextInputType.text,
                          onChanged: (String value) {
                            personProvider.changeAddress = value;
                          },
                          style: TextStyle(fontSize: 19),
                          decoration: orderInputDecoration("address", "address"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          initialValue: person.password,
                          keyboardType: TextInputType.visiblePassword,
                          onChanged: (String value) {
                            personProvider.changePassword = value;
                          },
                          style: TextStyle(fontSize: 19),
                          decoration: orderInputDecoration("password", "password"),
                        ),
                      ),
                    ]),
                  ),
                );
              } else {
                return Loading();
              }
            },
          ),
          clipPath(),
        ],
      ),
    );
  }
}
