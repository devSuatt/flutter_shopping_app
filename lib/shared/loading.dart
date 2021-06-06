import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hunters_group_project/shared/constants.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: drawerBackgroundColor,
      child: Center(
        child: SpinKitFadingCircle(color: Colors.blue[50], size: 100.0),
      ),
    );
  }
}
