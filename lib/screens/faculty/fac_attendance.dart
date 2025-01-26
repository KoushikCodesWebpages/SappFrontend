import 'package:flutter/material.dart';
import '../../models/faculty/fac_attendance_model.dart';

class FacAttendance extends StatelessWidget {
  const FacAttendance({super.key});

  // Mock Data
  final List<Map<String, dynamic>> studentData =
  const[
    {
      "student_name": "Alice Johnson",
      "class": "10th",
      "roll_number": 101,
      "attendance_percentage": 92
    },
    {
      "student_name": "Bob Smith",
      "class": "10th",
      "roll_number": 102,
      "attendance_percentage": 85
    },
    {
      "student_name": "Charlie Brown",
      "class": "9th",
      "roll_number": 201,
      "attendance_percentage": 88
    },
    {
      "student_name": "Daisy Williams",
      "class": "9th",
      "roll_number": 202,
      "attendance_percentage": 95
    },
    {
      "student_name": "Edward Martinez",
      "class": "8th",
      "roll_number": 301,
      "attendance_percentage": 78
    },
    {
      "student_name": "Fiona Garcia",
      "class": "8th",
      "roll_number": 302,
      "attendance_percentage": 90
    },
    {
      "student_name": "George Clark",
      "class": "10th",
      "roll_number": 103,
      "attendance_percentage": 83
    },
    {
      "student_name": "Hannah Adams",
      "class": "9th",
      "roll_number": 203,
      "attendance_percentage": 87
    },
    {
      "student_name": "Ian Thompson",
      "class": "8th",
      "roll_number": 303,
      "attendance_percentage": 92
    },
    {
      "student_name": "Julia Roberts",
      "class": "10th",
      "roll_number": 104,
      "attendance_percentage": 96
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Faculty Attendance'),
      ),
      body: ListView.builder(
        itemCount: studentData.length,
        itemBuilder: (context, index) {
          final student = studentData[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Student Details (on the left)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Name: ${student['student_name']}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text("Class: ${student['class']}"),
                        Text("Roll Number: ${student['roll_number']}"),
                      ],
                    ),
                  ),
                  // Attendance Bar and Percentage (on the right)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 150, // Set width for the progress bar
                        child: LinearProgressIndicator(
                          value: student['attendance_percentage'] / 100,
                          color: _getAttendanceColor(
                              student['attendance_percentage']),
                          backgroundColor: Colors.grey[300],
                          minHeight: 10,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "${student['attendance_percentage']}%",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Helper function to determine the color of the progress bar
  Color _getAttendanceColor(int attendancePercentage) {
    if (attendancePercentage >= 90) {
      return Colors.green;
    } else if (attendancePercentage >= 80) {
      return Colors.blue;
    } else {
      return Colors.red;
    }
  }
}