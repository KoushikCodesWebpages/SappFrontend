import 'package:eg/screens/faculty/class_details.dart';
import 'package:flutter/material.dart';
import '../../models/faculty/dashboard_details_model.dart';
import '../../services/faculty/dashboard_service.dart';
import '../../screens/faculty/attendance.dart';

class FacultyCard extends StatefulWidget {

  const FacultyCard({super.key});

  @override
  FacultyCardState createState() => FacultyCardState();
}

class FacultyCardState extends State<FacultyCard> {
  late Future<Faculty> _facultyFuture;

  @override
  void initState() {
    super.initState();
    _facultyFuture = FacultyService().fetchFacultyData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Faculty>(
      future: _facultyFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (snapshot.hasData) {
          Faculty faculty = snapshot.data!;
          String name = faculty.username;
          String classDetails = faculty.classTeacher[0];
          String section = faculty.classTeacher[1];
          String year = faculty.classTeacher[2];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ClassDetailsPage())//FacAttendance()), 
              );
            },
            child: SizedBox(
              width: double.infinity,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('Standard: $classDetails | Section: $section | $year', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
              ),
            ),
            )
          );
        } else {
          return const Center(child: Text("No data available"));
        }
      },
    );
  }
}
