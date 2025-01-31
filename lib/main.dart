//import 'package:eg/screens/menu.dart';
// import 'package:eg/screens/students/dashboard.dart';
// import 'package:eg/screens/students/login.dart';
import 'package:eg/screens/students/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  static const bool debugShowCheckedModeBanner = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Title',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
      debugShowCheckedModeBanner: false
    );
  }
}
