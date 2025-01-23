import 'package:eg/screens/menu.dart';
// import 'package:eg/screens/students/mdashboard.dart';
// import 'package:eg/screens/students/mstu_login.dart';
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
      home: const MenuPage(), // Set MenuPage as the home screen
    );
    //return const MenuPage();
  }
}
