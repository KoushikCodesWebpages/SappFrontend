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
          AppConstants.name = name;
          AppConstants.standard = classDetails;
          AppConstants.section = section;
          AppConstants.academicYear = data['academic_year'];
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
                        color: AppConstants.mainColor,
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



//single box - gradient
// import 'dart:convert';
// import 'package:eg/config/mapp_config.dart';
// import 'package:eg/screens/students/profile.dart';
// import 'package:eg/utils/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:eg/screens/students/attendance.dart';

// class StudentDetailsWidget extends StatefulWidget {
//   const StudentDetailsWidget({super.key});

//   @override
//   StudentDetailsWidgetState createState() => StudentDetailsWidgetState();
// }

// class StudentDetailsWidgetState extends State<StudentDetailsWidget> {
//   String name = "Loading...";
//   String classDetails = "";
//   String section = "";
//   double attendance = 0.0; // Default value
//   bool isProfileTapped = false;
//   bool isAttendanceTapped = false;

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
//           AppConstants.name = name;
//           AppConstants.standard = classDetails;
//           AppConstants.section = section;
//           AppConstants.academicYear = data['academic_year'];
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
//       constraints: BoxConstraints(minWidth: 700),
//       child: Card(
//         elevation: 6,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15),
//             gradient: LinearGradient(
//               colors: [AppConstants.mainColor, Colors.blue.shade900],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Profile Tap Area
//               GestureDetector(
//                 onTapDown: (_) {
//                   setState(() => isProfileTapped = true);
//                 },
//                 onTapUp: (_) {
//                   setState(() => isProfileTapped = false);
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) =>
//                           ProfilePage(accessToken: AppConfig.accessToken),
//                     ),
//                   );
//                 },
//                 onTapCancel: () {
//                   setState(() => isProfileTapped = false);
//                 },
//                 child: AnimatedContainer(
//                   duration: Duration(milliseconds: 200),
//                   decoration: BoxDecoration(
//                     border: isProfileTapped
//                         ? Border.all(color: Colors.blue, width: 2)
//                         : null,
//                     borderRadius: BorderRadius.circular(5),
//                   ),
//                   padding: EdgeInsets.all(8),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         name,
//                         style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white),
//                       ),
//                       Text(
//                         'Standard: $classDetails | Section: $section | Student',
//                         style: TextStyle(color: Colors.white70),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 8),

//               // Attendance Tap Area
//               GestureDetector(
//                 onTapDown: (_) {
//                   setState(() => isAttendanceTapped = true);
//                 },
//                 onTapUp: (_) {
//                   setState(() => isAttendanceTapped = false);
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => StuAttendance()),
//                   );
//                 },
//                 onTapCancel: () {
//                   setState(() => isAttendanceTapped = false);
//                 },
//                 child: AnimatedContainer(
//                   duration: Duration(milliseconds: 200),
//                   decoration: BoxDecoration(
//                     border: isAttendanceTapped
//                         ? Border.all(color: Colors.blue, width: 2)
//                         : null,
//                     borderRadius: BorderRadius.circular(5),
//                   ),
//                   padding: EdgeInsets.all(8),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('Attendance',
//                           style: TextStyle(color: Colors.white)),
//                       LinearProgressIndicator(
//                         value: attendance,
//                         color: Colors.white,
//                         backgroundColor: Colors.white30,
//                       ),
//                       SizedBox(height: 4),
//                       Text(
//                         '${(attendance * 100).toInt()}%',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }




//two diff boxes - light colours
// import 'dart:convert';
// import 'package:eg/config/mapp_config.dart';
// import 'package:eg/screens/students/profile.dart';
// import 'package:eg/utils/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:eg/screens/students/attendance.dart';

// class StudentDetailsWidget extends StatefulWidget {
//   const StudentDetailsWidget({super.key});

//   @override
//   StudentDetailsWidgetState createState() => StudentDetailsWidgetState();
// }

// class StudentDetailsWidgetState extends State<StudentDetailsWidget> {
//   String name = "Loading...";
//   String classDetails = "";
//   String section = "";
//   double attendance = 0.0; // Default value
//   bool isProfileTapped = false;
//   bool isAttendanceTapped = false;

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
//           AppConstants.name = name;
//           AppConstants.standard = classDetails;
//           AppConstants.section = section;
//           AppConstants.academicYear = data['academic_year'];
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
//       constraints: const BoxConstraints(minWidth: 700),
//       child: Card(
//         elevation: 8, // Gives a raised effect
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//         color: Colors.white, // White card background
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Profile Tap Area
//               GestureDetector(
//                 onTapDown: (_) {
//                   setState(() => isProfileTapped = true);
//                 },
//                 onTapUp: (_) {
//                   setState(() => isProfileTapped = false);
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => ProfilePage(accessToken: AppConfig.accessToken),
//                     ),
//                   );
//                 },
//                 onTapCancel: () {
//                   setState(() => isProfileTapped = false);
//                 },
//                 child: AnimatedContainer(
//                   duration: const Duration(milliseconds: 200),
//                   decoration: BoxDecoration(
//                     color: Colors.blue.shade50,
//                     border: isProfileTapped ? Border.all(color: Colors.blue, width: 2) : null,
//                     borderRadius: BorderRadius.circular(12),
//                     boxShadow: [
//                       if (isProfileTapped)
//                         BoxShadow(color: Colors.blue.withOpacity(0.4), blurRadius: 6)
//                     ],
//                   ),
//                   padding: const EdgeInsets.all(12),
//                   child: Row(
//                     children: [
//                       const Icon(Icons.person, color: Colors.blue, size: 30),
//                       const SizedBox(width: 10),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
//                           Text('Standard: $classDetails | Section: $section | Student',
//                               style: TextStyle(color: Colors.grey.shade700)),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 12),

//               // Attendance Tap Area
//               GestureDetector(
//                 onTapDown: (_) {
//                   setState(() => isAttendanceTapped = true);
//                 },
//                 onTapUp: (_) {
//                   setState(() => isAttendanceTapped = false);
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const StuAttendance()),
//                   );
//                 },
//                 onTapCancel: () {
//                   setState(() => isAttendanceTapped = false);
//                 },
//                 child: AnimatedContainer(
//                   duration: const Duration(milliseconds: 200),
//                   decoration: BoxDecoration(
//                     color: Colors.blue.shade50,
//                     border: isAttendanceTapped ? Border.all(color: Colors.blue, width: 2) : null,
//                     borderRadius: BorderRadius.circular(12),
//                     boxShadow: [
//                       if (isAttendanceTapped)
//                         BoxShadow(color: Colors.blue.withOpacity(0.4), blurRadius: 6)
//                     ],
//                   ),
//                   padding: const EdgeInsets.all(12),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text('Attendance', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600)),
//                       const SizedBox(height: 6),
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(10),
//                         child: LinearProgressIndicator(
//                           value: attendance,
//                           minHeight: 10,
//                           backgroundColor: Colors.grey.shade300,
//                           valueColor: AlwaysStoppedAnimation<Color>(
//                             Colors.blue.shade400, // Smooth blue gradient effect
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 6),
//                       Text('${(attendance * 100).toInt()}%',
//                           style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
