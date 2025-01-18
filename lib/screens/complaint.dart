import 'package:flutter/material.dart';

class ComplaintPage extends StatelessWidget {
  const ComplaintPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Complaint Box'),
        ),
      ),
    );
  }
}