import "package:flutter/material.dart";
import 'package:hhc/Screens/Home.dart';

import 'Screens/Login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: {
      '/login': (context) => LoginPage(),
    }, theme: ThemeData(primarySwatch: Colors.blue), home: LoginPage());
  }
}
