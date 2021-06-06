import 'package:flutter/material.dart';
import 'package:hunters_group_project/models/person.dart';
import 'package:hunters_group_project/models/user.dart';
import 'package:hunters_group_project/screens/admin/admin_home.dart';
import 'package:hunters_group_project/screens/authenticate/authenticate.dart';
import 'package:hunters_group_project/screens/authorization.dart';
import 'package:hunters_group_project/services/db_services.dart';
import 'package:hunters_group_project/shared/functions.dart';
import 'package:provider/provider.dart';

class Authentication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Users user = Provider.of<Users>(context);

    if (user == null) {
      return Authenticate();
    } else {
      Person person;
      return StreamProvider<Person>.value(
        initialData: person,
        value: DatabaseServices(uid: user.uid).userData,
        child: Authorization(),
      );
    }
  }
}
