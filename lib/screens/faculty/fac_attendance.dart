import 'package:flutter/material.dart';

class FacAttendance extends StatelessWidget {
  const FacAttendance({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Faculty Attendance'),
        ),
      ),
    );
  }
}