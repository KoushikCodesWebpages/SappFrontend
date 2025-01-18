import 'package:flutter/material.dart';

class StuDashboard extends StatelessWidget {
  const StuDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Student Dashboard page'),
        ),
      ),
    );
  }
}