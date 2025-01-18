import 'package:flutter/material.dart';

class AdminCalendar extends StatelessWidget {
  const AdminCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Admin Calendar'),
        ),
      ),
    );
  }
}