import 'package:flutter/material.dart';

class StuTimetable extends StatelessWidget {
  const StuTimetable({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Student Time Table'),
        ),
      ),
    );
  }
}