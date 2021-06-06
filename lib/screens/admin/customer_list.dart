import 'package:flutter/material.dart';
import 'package:hunters_group_project/models/person.dart';
import 'package:hunters_group_project/providers/person_provider.dart';
import 'package:hunters_group_project/screens/admin_drawer.dart';
import 'package:hunters_group_project/shared/functions.dart';
import 'package:hunters_group_project/shared/loading.dart';
import 'package:provider/provider.dart';

class CustomerList extends StatefulWidget {
  final Person person;
  CustomerList({this.person});
  @override
  _CustomerListState createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  PersonProvider _personProvider;

  @override
  void initState() {
    super.initState();
    _personProvider = Provider.of<PersonProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdminDrawer(person: widget.person),
      appBar: myAppBar("Customer List", false),
      backgroundColor: Colors.amber[50],
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            child: StreamBuilder<List<Person>>(
              stream: _personProvider.users ?? [],
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Person> users = snapshot.data ?? [];
                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(10),
                        decoration: boxDecoration(20, Colors.amber),
                        child: ExpansionTile(
                          leading: Padding(
                            padding: const EdgeInsets.only(top: 7),
                            child: Icon(Icons.person),
                          ),
                          title: Text(
                            users[index].userName.toUpperCase(),
                            style: TextStyle(fontSize: 20, color: Colors.blueGrey[800]),
                          ),
                          subtitle: Text(
                            users[index].email,
                            style: TextStyle(fontSize: 15, color: Colors.deepPurple[800], fontWeight: FontWeight.w300),
                          ),
                          children: [
                            Divider(endIndent: 10, indent: 10, thickness: 1),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                              alignment: Alignment.topLeft,
                              child: Text("ADDRESS: " + users[index].address, style: TextStyle(fontSize: 17, color: Colors.blueGrey[800])),
                            ),
                          ],
                        ),
                      );
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
}
