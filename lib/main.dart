import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hunters_group_project/models/user.dart';
import 'package:hunters_group_project/providers/person_provider.dart';
import 'package:hunters_group_project/providers/product_provider.dart';
import 'package:hunters_group_project/screens/admin/product_page.dart';
import 'package:hunters_group_project/screens/authentication.dart';
import 'package:hunters_group_project/screens/profile.dart';
import 'package:hunters_group_project/services/auth_services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Users users;
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Users>.value(
      initialData: users,
      value: AuthServices().user,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ProductProvider()),
          ChangeNotifierProvider(create: (context) => PersonProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Hunters CRM',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routes: {
            'Profile': (context) => Profile(),
            'ProductPage': (context) => ProductPage(),
          },
          home: App(title: 'Hunters CRM'),
        ),
      ),
    );
  }
}

class App extends StatefulWidget {
  final String title;
  App({this.title});
  // Create the initialization Future outside of `build`:
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: Text(widget.title)),
            body: Center(child: Text("HATA!")),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return Authentication();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Scaffold(
          appBar: AppBar(title: Text(widget.title)),
          body: CircularProgressIndicator(),
        );
      },
    );
  }
}
