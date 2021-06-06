import 'package:flutter/material.dart';
import 'package:hunters_group_project/models/person.dart';
import 'package:hunters_group_project/screens/admin/admin_home.dart';
import 'package:hunters_group_project/screens/customer/customer_home.dart';
import 'package:provider/provider.dart';

class Authorization extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // null hatası almamak için geçici bir nesne oluşturduk:
    Person temp = Person(personId: "", userName: "", address: "", email: "", isAdmin: false, password: "");
    Person person = Provider.of<Person>(context) ?? temp;

    if (person.isAdmin) {
      return AdminHomePage(person: person);
    } else {
      return CustomerHomePage(person: person);
    }

  }
}

