import 'dart:convert';
import 'package:eg/config/mapp_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:eg/screens/students/attendance.dart';

class StudentDetailsWidget extends StatefulWidget {
  const StudentDetailsWidget({super.key});

  @override
  _StudentDetailsWidgetState createState() => _StudentDetailsWidgetState();
}

class _StudentDetailsWidgetState extends State<StudentDetailsWidget> {
  String name = "Loading...";
  String classDetails = "";
  String section = "";
  double attendance = 0.0; // Default value

  @override
  void initState() {
    super.initState();
    fetchStudentDetails();
  }

  Future<void> fetchStudentDetails() async {
    String accessToken = AppConfig.accessToken; // Replace with actual token
    String apiUrl = AppConfig.profileUrl; // Replace with actual API URL

    try {
      var response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        
        setState(() {
          name = data['user']['username'];
          classDetails = data['standard'].toString();
          section = data['section'];
          attendance = data['attendance_percent'].toDouble(); 
        });
      } else {
        print("Error: ${response.body}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => StuAttendance()), 
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('Standard: $classDetails | Section: $section', style: TextStyle(color: Colors.grey)),
              SizedBox(height: 8),
              Text('Attendance', style: TextStyle(color: Colors.black)),
              LinearProgressIndicator(
                value: attendance,
                color: Colors.blue,
                backgroundColor: Colors.grey[300],
              ),
              SizedBox(height: 4),
              Text('${(attendance * 100).toInt()}%', style: TextStyle(color: Colors.black)),
            ],
          ),
        ),
      ),
    );
  }
}
