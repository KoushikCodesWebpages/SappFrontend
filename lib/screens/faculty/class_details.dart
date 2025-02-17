import 'package:flutter/material.dart';
import 'stu_details.dart';

class ClassDetailsPage extends StatelessWidget {
  ClassDetailsPage({super.key});

  final List<String> timeSlots = [
    "Period 1", "Period 2", "Period 3", "Period 4", "Period 5",
    "Period 6", "Period 7", "Period 8", "Period 9", "Period 10", "Period 11"
  ];

  final Map<String, List<String>> schedule = {
    "Monday": ["Math", "Science", "English", "History", "PE", "Art", "", "", "", "", ""],
    "Tuesday": ["Biology", "Chemistry", "Physics", "Math", "English", "Geography", "", "", "", "", ""],
    "Wednesday": ["History", "PE", "Math", "Science", "English", "Art", "", "", "", "", ""],
    "Thursday": ["Chemistry", "Physics", "Biology", "Math", "Geography", "History", "", "", "", "", ""],
    "Friday": ["English", "Math", "Science", "History", "Art", "PE", "", "", "", "", ""],
  };

  final List<Map<String, String>> students = [
    {'name': 'Alice Johnson', 'id': 'S101'},
    {'name': 'Bob Smith', 'id': 'S102'},
    {'name': 'Charlie Brown', 'id': 'S103'},
    {'name': 'David Williams', 'id': 'S104'},
    {'name': 'Emma Wilson', 'id': 'S105'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Class Details")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            // Class Info Card
            // Card(
            //   margin: const EdgeInsets.all(10),
            //   child: Padding(
            //     padding: const EdgeInsets.all(10),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: const [
            //         Text("Academic Year: 2024-2025", style: TextStyle(fontWeight: FontWeight.bold)),
            //         Text("Standard: 10th Grade"),
            //         Text("Section: A"),
            //         Text("Faculty: Dr. Smith"),
            //       ],
            //     ),
            //   ),
            // ),

            // Timetable
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                border: TableBorder.all(color: Colors.black),
                columns: [
                  const DataColumn(label: Text("Day", style: TextStyle(fontWeight: FontWeight.bold))),
                  ...timeSlots.map((slot) => DataColumn(label: Text(slot, style: const TextStyle(fontWeight: FontWeight.bold)))),
                ],
                rows: schedule.entries.map((entry) {
                  return DataRow(cells: [
                    DataCell(Text(entry.key, style: const TextStyle(fontWeight: FontWeight.bold))),
                    ...List.generate(11, (index) => DataCell(
                        index < entry.value.length ? Text(entry.value[index]) : const Text("")))
                  ]);
                }).toList(),
              ),
            ),

            const Divider(),

            // Student List
            const Text("Students", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ...students.map((student) => Card(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(student['name']!),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StudentDetailsPage(
      studentData: {
        "user": {
          "username": "student1@student.com",
          "email": "student1@student.com",
          "role": "student"
        },
        "enrollment_number": "ENR001",
        "standard": 9,
        "section": "C",
        "subjects": ["Math", "Science", "English", "History", "Geography"],
        "academic_year": "2024-2025",
        "attendance_percent": 85,
        "student_code": "student1@student.com-9-C",
        "image": null,  // Change to an image URL if available
      },
    ),
                        ),
                      );
                    },
                  ),
                )),
          ],
        ),
      ),
    );
  }
}