import 'package:flutter/material.dart';

class StuAttendance extends StatelessWidget {
  const StuAttendance({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Student Attendance page'),
        ),
      ),
    );
  }
}