// import 'package:flutter/material.dart';
// import 'stu_details.dart';
// import '../../models/students/timetable_model.dart';
// import '../../services/students/timetable_service.dart';

// class ClassDetailsPage extends StatefulWidget {
//   final String accessToken;

//   const ClassDetailsPage({super.key, required this.accessToken});

//   @override
//   ClassDetailsPageState createState() => ClassDetailsPageState();
// }

// class ClassDetailsPageState extends State<ClassDetailsPage> {
//   Timetable? timetable;
//   bool isLoading = true;

//   final List<String> timeSlots = [
//     "Period 1", "Period 2", "Period 3", "Period 4", "Period 5",
//     "Period 6", "Period 7", "Period 8", "Period 9", "Period 10", "Period 11"
//   ]; // 11 periods

//     final List<Map<String, String>> students = [
//     {'name': 'Alice Johnson', 'id': 'S101'},
//     {'name': 'Bob Smith', 'id': 'S102'},
//     {'name': 'Charlie Brown', 'id': 'S103'},
//     {'name': 'David Williams', 'id': 'S104'},
//     {'name': 'Emma Wilson', 'id': 'S105'},
//   ];

//   @override
//   void initState() {
//     super.initState();
//     fetchTimetable();
//   }

//   Future<void> fetchTimetable() async {
//     Timetable? fetchedTimetable =
//         await TimetableService.fetchTimetable(widget.accessToken);
//     setState(() {
//       timetable = fetchedTimetable;
//       print(timetable);
//       isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Class Details")),
//       body: isLoading
//         ? const Center(child: CircularProgressIndicator()) // Show loading indicator
//         : timetable == null
//             ? const Center(child: Text("Failed to load timetable")) // Handle null case
//             : SingleChildScrollView(
//         padding: const EdgeInsets.all(10),
//         child: Column(
//           children: [
//             SingleChildScrollView(
//                     scrollDirection: Axis.horizontal, // Allow horizontal scrolling
//                     child: SingleChildScrollView(
//                       scrollDirection: Axis.vertical, // Allow vertical scrolling
//                       child: DataTable(
//                         border: TableBorder.all(color: Colors.black),
//                         columns: _generateColumns(),
//                         rows: _generateRows(),
//                       ),
//                     ),
//                   ),

//             const Divider(),

//             // Student List
//             const Text("Students", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//             ...students.map((student) => Card(
//                   margin: const EdgeInsets.symmetric(vertical: 5),
//                   child: ListTile(
//                     leading: const Icon(Icons.person),
//                     title: Text(student['name']!),
//                     trailing: const Icon(Icons.arrow_forward_ios),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => StudentDetailsPage(
//       studentData: {
//         "user": {
//           "username": "student1@student.com",
//           "email": "student1@student.com",
//           "role": "student"
//         },
//         "enrollment_number": "ENR001",
//         "standard": 9,
//         "section": "C",
//         "subjects": ["Math", "Science", "English", "History", "Geography"],
//         "academic_year": "2024-2025",
//         "attendance_percent": 85,
//         "student_code": "student1@student.com-9-C",
//         "image": null,  // Change to an image URL if available
//       },
//     ),
//                         ),
//                       );
//                     },
//                   ),
//                 )),
//           ],
//         ),
//       ),
//     );
//   }

//   List<DataColumn> _generateColumns() {
//     return [
//       const DataColumn(
//           label: Text("Day", style: TextStyle(fontWeight: FontWeight.bold))),
//       ...timeSlots.map((slot) => DataColumn(
//           label: Text(slot, style: const TextStyle(fontWeight: FontWeight.bold))))
//     ];
//   }

//   // Generate rows with each day's subjects aligned under the correct period
//   List<DataRow> _generateRows() {
//     if (timetable == null || timetable!.schedule.isEmpty) {
//     return [];
//   }
//     List<DataRow> rows = [];

//     for (String day in ["monday", "tuesday", "wednesday", "thursday", "friday"]) {
//       if (timetable!.schedule[day] != null) {
//         List<String> subjects = timetable!.schedule[day]!;

//         // Create row for the day
//         rows.add(DataRow(cells: [
//           DataCell(Text(day.substring(0,3).toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold))),
//           ...List.generate(11, (index) => DataCell(
//               index < subjects.length ? Text(subjects[index]) : const Text("")))
//         ]));
//       }
//     }

//     return rows;
//   }
// }

import 'package:flutter/material.dart';
import 'stu_details.dart';
import '../../models/faculty/stu_list_model.dart';
import '../../services/faculty/stu_list_service.dart';
import '../../models/students/timetable_model.dart';
import '../../services/students/timetable_service.dart';

class ClassDetailsPage extends StatefulWidget {
  final String accessToken;

  const ClassDetailsPage({super.key, required this.accessToken});

  @override
  ClassDetailsPageState createState() => ClassDetailsPageState();
}

class ClassDetailsPageState extends State<ClassDetailsPage> {
  Timetable? timetable;
  List<Student> students = [];
  bool isLoading = true;

  List<String>? timeSlots;// = List.generate(timetable.schedule[0].length, (i) => "Period ${i + 1}");
  // [
  //   "Period 1", "Period 2", "Period 3", "Period 4", "Period 5",
  //   "Period 6", "Period 7", "Period 8", "Period 9", "Period 10", "Period 11"
  // ];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final fetchedTimetable = await TimetableService.fetchTimetable(widget.accessToken);
      final fetchedStudents = await StudentService.fetchStudents(widget.accessToken);

      setState(() {
        timetable = fetchedTimetable;
        timeSlots = List.generate(timetable!.schedule["monday"]!.length, (i) => "Period ${i + 1}");
        print(timeSlots);
        students = fetchedStudents;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Class Details")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: DataTable(
                        border: TableBorder.all(color: Colors.black),
                        columns: _generateColumns(),
                        rows: _generateRows(),
                      ),
                    ),
                  ),
                  const Divider(),
                  const Text(
                    "Students",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  ...students.map((student) => Card(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: ListTile(
                          leading: const Icon(Icons.person),
                          title: Text(student.username),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StudentDetailsPage(
                                  studentData: {
                                    "user": {
                                      "username": student.username,
                                      "email": "${student.username}@student.com",
                                      "role": "student"
                                    },
                                    "student_code": student.studentCode,
                                    "image": null,
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

  List<DataColumn> _generateColumns() {
    return [
      const DataColumn(label: Text("Day", style: TextStyle(fontWeight: FontWeight.bold))),
      ...timeSlots!.map((slot) => DataColumn(
          label: Text(slot, style: const TextStyle(fontWeight: FontWeight.bold))))
    ];
  }

  List<DataRow> _generateRows() {
    if (timetable == null || timetable!.schedule.isEmpty) {
      return [];
    }
    List<DataRow> rows = [];

    for (String day in ["monday", "tuesday", "wednesday", "thursday", "friday"]) {
      if (timetable!.schedule[day] != null) {
        List<String> subjects = timetable!.schedule[day]!;
        rows.add(DataRow(cells: [
          DataCell(Text(day.substring(0, 3).toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.bold))),
          ...List.generate(11, (index) => DataCell(
              index < subjects.length ? Text(subjects[index]) : const Text("")))
        ]));
      }
    }

    return rows;
  }
}
