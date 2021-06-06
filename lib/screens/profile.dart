import 'package:flutter/material.dart';
import 'package:hunters_group_project/models/person.dart';
import 'package:hunters_group_project/providers/person_provider.dart';
import 'package:hunters_group_project/screens/admin_drawer.dart';
import 'package:hunters_group_project/screens/customer_drawer.dart';
import 'package:hunters_group_project/screens/profile_edit.dart';
import 'package:hunters_group_project/services/db_services.dart';
import 'package:hunters_group_project/shared/constants.dart';
import 'package:hunters_group_project/shared/functions.dart';
import 'package:hunters_group_project/shared/loading.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  final Person person;
  Profile({this.person});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  PersonProvider personProvider;
  @override
  void initState() {
    super.initState();
    personProvider = Provider.of<PersonProvider>(context, listen: false);
    personProvider.loadAllPersons(widget.person);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        "MY PROFILE",
        true,
        myIcon: Icons.edit,
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileEditPage(person: widget.person)));
        },
      ),
      drawer: widget.person.isAdmin ? AdminDrawer(person: widget.person) : CustomerDrawer(person: widget.person),
      body: Stack(
        children: [
          StreamBuilder<Person>(
            stream: DatabaseServices(uid: widget.person.personId).userData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Person person = snapshot.data;
                return ListView(
                  children: [
                    SizedBox(height: 45),
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(widget.person.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 25),
                    boxTemplate("User Name", person.userName),
                    SizedBox(height: 5),
                    boxTemplate("Email Address", person.email),
                    SizedBox(height: 5),
                    boxTemplate("Address", person.address),
                  ],
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
