import 'package:flutter/material.dart';

class StudentDetailsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('K. Ajay Shanmugam', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  //Text('Class XI - C | Roll no: 34', style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 8),
                  Text('Attendance', style: TextStyle(color: Colors.black)),
                  LinearProgressIndicator(
                    value: 0.8,
                    color: Colors.blue,
                    backgroundColor: Colors.grey[300],
                  ),
                  SizedBox(height: 4),
                  Text('80%', style: TextStyle(color: Colors.black)),
                ],
              ),
      ),
    );
  }
}
