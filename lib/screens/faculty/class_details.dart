import 'package:flutter/material.dart';
import 'stu_details.dart';
import '../../models/faculty/stu_list_model.dart';
import '../../services/faculty/stu_list_service.dart';
import '../../models/students/timetable_model.dart';
import '../../services/students/timetable_service.dart';
import '../../utils/constants.dart'; 

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
  int maxPeriods = 0;

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
        maxPeriods = timetable!.schedule.values.map((list) => list.length).reduce((a, b) => a > b ? a : b);
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
      backgroundColor: AppConstants.mainColor.withOpacity(0.1),
      appBar: AppBar(
        title: const Text("Class Details", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: AppConstants.mainColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle("Timetable"),
                  const SizedBox(height: 10),
                  _buildTimetableCard(),
                  const Divider(height: 30, thickness: 1),

                  _buildSectionTitle("Students"),
                  const SizedBox(height: 10),
                  _buildStudentList(),
                ],
              ),
            ),
    );
  }

  /// Custom styled section title
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: AppConstants.mainColor,
      ),
    );
  }

  /// Wraps the timetable inside a Card
  Widget _buildTimetableCard() {
    if (timetable == null || timetable!.schedule.isEmpty) {
      return const Text("No timetable available");
    }

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            border: TableBorder.all(color: Colors.black.withOpacity(0.2)),
            headingRowColor: MaterialStateProperty.all(AppConstants.mainColor),
            headingTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            columns: _generateTableColumns(),
            rows: _generateTableRows(),
          ),
        ),
      ),
    );
  }

  List<DataColumn> _generateTableColumns() {
    return [
      const DataColumn(
          label: Text("PERIOD", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
      ...["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"].map(
        (day) => DataColumn(
          label: Text(
            day.substring(0, 3).toUpperCase(),
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    ];
  }

  List<DataRow> _generateTableRows() {
    List<DataRow> rows = [];
    int periodNumber = 1;

    for (int i = 0; i < maxPeriods; i++) {
      bool isShortBreak = false;

      List<String> subjects = ["monday", "tuesday", "wednesday", "thursday", "friday"].map((day) {
        if (timetable!.schedule[day] != null && i < timetable!.schedule[day]!.length) {
          return timetable!.schedule[day]![i];
        }
        return "-";
      }).toList();

      if (subjects.contains("Break")) {
        isShortBreak = true;
      }

      rows.add(DataRow(cells: [
        DataCell(Text(
          isShortBreak ? "Break" : "P$periodNumber",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        )),
        ...subjects.map((subject) => DataCell(Text(subject))),
      ]));

      if (!isShortBreak) {
        periodNumber++;
      }
    }

    return rows;
  }

  /// Styled student list with improved UI
  Widget _buildStudentList() {
    return Column(
      children: students.map((student) {
        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            leading: CircleAvatar(
              backgroundColor: AppConstants.mainColor.withOpacity(0.1),
              child: const Icon(Icons.person, color: Colors.black),
            ),
            title: Text(student.username, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            trailing: const Icon(Icons.arrow_forward_ios, size: 18),
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
        );
      }).toList(),
    );
  }
}
