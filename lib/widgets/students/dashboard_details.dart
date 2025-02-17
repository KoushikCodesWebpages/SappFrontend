import 'dart:convert';
import 'package:eg/config/mapp_config.dart';
import 'package:eg/screens/students/profile.dart';
import 'package:eg/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:eg/screens/students/attendance.dart';

class StudentDetailsWidget extends StatefulWidget {
  const StudentDetailsWidget({super.key});

  @override
  StudentDetailsWidgetState createState() => StudentDetailsWidgetState();
}

// class StudentDetailsWidgetState extends State<StudentDetailsWidget> {
//   String name = "Loading...";
//   String classDetails = "";
//   String section = "";
//   double attendance = 0.0; // Default value

//   @override
//   void initState() {
//     super.initState();
//     fetchStudentDetails();
//   }

//   Future<void> fetchStudentDetails() async {
//     String accessToken = AppConfig.accessToken; 
//     String apiUrl = AppConfig.stuProfileUrl; 

//     try {
//       var response = await http.get(
//         Uri.parse(apiUrl),
//         headers: {
//           'Authorization': 'Bearer $accessToken',
//           'Content-Type': 'application/json',
//         },
//       );

//       if (response.statusCode == 200) {
//         var data = jsonDecode(response.body);
        
//         setState(() {
//           name = data['user']['username'];
//           classDetails = data['standard'].toString();
//           section = data['section'];
//           attendance = data['attendance_percent'].toDouble(); 
//         });
//       } else {
//         print("Error: ${response.body}");
//       }
//     } catch (e) {
//       print("Exception: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ConstrainedBox(
//             constraints: BoxConstraints(
//               minWidth: 700
//             ),
//         child: Card(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => ProfilePage(accessToken: AppConfig.accessToken,)), 
//         );
//       },
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//               Text(name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//               Text('Standard: $classDetails | Section: $section | Student', style: TextStyle(color: Colors.grey)),
//               ] ) 
//               ),
//               SizedBox(height: 8),
//               GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => StuAttendance()), 
//         );
//       },
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//               Text('Attendance', style: TextStyle(color: Colors.black)),
//               LinearProgressIndicator(
//                 value: attendance,
//                 color: Colors.blue,
//                 backgroundColor: Colors.grey[300],
//               ),
//               SizedBox(height: 4),
//               Text('${(attendance * 100).toInt()}%', style: TextStyle(color: Colors.black)),
//               ] ) )
//             ],
//           ),
//           ),
//         ),
//     );
//   }
// }


class StudentDetailsWidgetState extends State<StudentDetailsWidget> {
  String name = "Loading...";
  String classDetails = "";
  String section = "";
  double attendance = 0.0; // Default value
  bool isProfileTapped = false;
  bool isAttendanceTapped = false;

  @override
  void initState() {
    super.initState();
    fetchStudentDetails();
  }

  Future<void> fetchStudentDetails() async {
    String accessToken = AppConfig.accessToken; 
    String apiUrl = AppConfig.stuProfileUrl; 

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
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: 700),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Tap Area
              GestureDetector(
                onTapDown: (_) {
                  setState(() => isProfileTapped = true);
                },
                onTapUp: (_) {
                  setState(() => isProfileTapped = false);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(accessToken: AppConfig.accessToken),
                    ),
                  );
                },
                onTapCancel: () {
                  setState(() => isProfileTapped = false);
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    border: isProfileTapped
                        ? Border.all(color: Colors.blue, width: 2)
                        : null,
                    // boxShadow: isProfileTapped? 
                    // [BoxShadow(
                    //   color: Colors.grey,
                    //   blurRadius: 10.0,
                    // )]: null,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('Standard: $classDetails | Section: $section | Student',
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8),

              // Attendance Tap Area
              GestureDetector(
                onTapDown: (_) {
                  setState(() => isAttendanceTapped = true);
                },
                onTapUp: (_) {
                  setState(() => isAttendanceTapped = false);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StuAttendance()),
                  );
                },
                onTapCancel: () {
                  setState(() => isAttendanceTapped = false);
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    border: isAttendanceTapped
                        ? Border.all(color: Colors.blue, width: 2)
                        : null,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
            ],
          ),
        ),
      ),
    );
  }
}
