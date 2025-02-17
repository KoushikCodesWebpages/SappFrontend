import 'package:flutter/material.dart';

class StudentDetailsPage extends StatelessWidget {
  final Map<String, dynamic> studentData;

  const StudentDetailsPage({super.key, required this.studentData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(studentData['user']['username'])),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(20),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Show image if available, else show a default icon
                studentData['image'] != null
                    ? CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(studentData['image']),
                      )
                    : const Icon(Icons.person, size: 80, color: Colors.blue),

                const SizedBox(height: 10),
                
                Text(studentData['user']['username'], 
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                
                Text("Enrollment: ${studentData['enrollment_number']}", 
                    style: const TextStyle(fontSize: 16)),
                
                Text("Standard: ${studentData['standard']} - Section: ${studentData['section']}", 
                    style: const TextStyle(fontSize: 16)),
                
                Text("Academic Year: ${studentData['academic_year']}", 
                    style: const TextStyle(fontSize: 16)),

                Text("Attendance: ${studentData['attendance_percent']}%", 
                    style: const TextStyle(fontSize: 16, color: Colors.red)),

                const SizedBox(height: 10),

                const Text("Subjects:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                
                // Subjects List
                Column(
                  children: (studentData['subjects'] as List<String>)
                      .map((subject) => Text(subject, style: const TextStyle(fontSize: 16)))
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
