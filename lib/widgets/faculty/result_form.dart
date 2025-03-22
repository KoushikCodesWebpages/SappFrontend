// import 'package:flutter/material.dart';
// import '../../models/faculty/result_post.dart';
// import '../../services/faculty/results_service.dart';

// class ResultInputForm extends StatelessWidget {
//   final String testTitle;
//   final String accessToken;
//   final ApiService _apiService = ApiService();

//   ResultInputForm({Key? key, required this.testTitle, required this.accessToken}) : super(key: key);

//   final TextEditingController _studentController = TextEditingController();
//   final TextEditingController _marksController = TextEditingController();

//   void _submitResult(BuildContext context) async {
//     StudentResult result = StudentResult(
//       student: _studentController.text,
//       resultLock: testTitle,
//       subject: "Maths",
//       marks: {"obtained": int.parse(_marksController.text), "total": 100},
//     );

//     await _apiService.postResults(accessToken, [result]);
//     Navigator.pop(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Enter Marks for $testTitle")),
//       body: Container(
//         alignment: AlignmentDirectional.topStart,
//         padding: EdgeInsets.all(25.0),
//       child: Column(
//         children: [
//           TextField(controller: _studentController, decoration: InputDecoration(labelText: "Student Code")),
//           TextField(controller: _marksController, decoration: InputDecoration(labelText: "Marks Obtained")),
//           TextButton(onPressed: () => _submitResult(context), child: Text("Submit"))
//         ],
//       ),
//       )
//     );
//   }
// }

//-------------------------------------------------------------------
// import 'package:eg/config/mapp_config.dart';
// import 'package:eg/services/faculty/stu_list_service.dart';
// import 'package:flutter/material.dart';
// import '../../models/faculty/result_post.dart';
// import '../../services/faculty/results_service.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class ResultInputForm extends StatefulWidget {
//   final String testTitle;
//   final String accessToken;

//   ResultInputForm({Key? key, required this.testTitle, required this.accessToken}) : super(key: key);

//   @override
//   _ResultInputFormState createState() => _ResultInputFormState();
// }

// class _ResultInputFormState extends State<ResultInputForm> {
//   final ApiService _apiService = ApiService();
//   List<Map<String, dynamic>> students = [];
//   Map<String, TextEditingController> marksControllers = {};
//   bool isLoading = true;
//   String? errorMessage;

//   @override
//   void initState() {
//     super.initState();
//     StudentService.fetchStudents(AppConfig.accessToken);
//     //fetchStudents();
//   }

//   /// Fetches students from the API
//   Future<void> fetchStudents() async {
//     try {
//       final response = await http.get(
//         Uri.parse("YOUR_API_URL_HERE"), // Replace with actual API URL
//         headers: {
//           "Authorization": "Bearer ${widget.accessToken}",
//           "Content-Type": "application/json",
//         },
//       );

//       if (response.statusCode == 200) {
//         List<dynamic> data = jsonDecode(response.body);
//         setState(() {
//           students = data.map((student) => {
//                 "student_code": student["student_code"],
//                 "user__username": student["user__username"],
//               }).toList();

//           // Initialize controllers for marks
//           for (var student in students) {
//             marksControllers[student["student_code"]] = TextEditingController();
//           }

//           isLoading = false;
//         });
//       } else {
//         setState(() {
//           errorMessage = "Failed to fetch students: ${response.body}";
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         errorMessage = "Error fetching students: $e";
//         isLoading = false;
//       });
//     }
//   }

//   /// Submits results for all students
//   void _submitResults() async {
//     List<StudentResult> results = students.map((student) {
//       return StudentResult(
//         student: student["student_code"],
//         resultLock: widget.testTitle,
//         subject: "Maths",
//         marks: {
//           "obtained": int.tryParse(marksControllers[student["student_code"]]?.text ?? "0") ?? 0,
//           "total": 100,
//         },
//       );
//     }).toList();

//     await _apiService.postResults(widget.accessToken, results);
//     Navigator.pop(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Enter Marks for ${widget.testTitle}")),
//       body: isLoading
//           ? Center(child: CircularProgressIndicator())
//           : errorMessage != null
//               ? Center(child: Text(errorMessage!))
//               : Padding(
//                   padding: EdgeInsets.all(16.0),
//                   child: Column(
//                     children: [
//                       Expanded(
//                         child: ListView.builder(
//                           itemCount: students.length,
//                           itemBuilder: (context, index) {
//                             final student = students[index];
//                             return Card(
//                               child: ListTile(
//                                 title: Text(student["user__username"]),
//                                 subtitle: Text("Code: ${student["student_code"]}"),
//                                 trailing: SizedBox(
//                                   width: 80,
//                                   child: TextField(
//                                     controller: marksControllers[student["student_code"]],
//                                     keyboardType: TextInputType.number,
//                                     decoration: InputDecoration(labelText: "Marks"),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                       ElevatedButton(
//                         onPressed: _submitResults,
//                         child: Text("Submit All"),
//                       ),
//                     ],
//                   ),
//                 ),
//     );
//   }
// }

//---------------------------------------
import 'package:flutter/material.dart';
import '../../models/faculty/stu_list_model.dart';
import '../../models/faculty/result_post.dart';
import '../../services/faculty/stu_list_service.dart';
import '../../services/faculty/results_service.dart';

class ResultInputForm extends StatefulWidget {
  final String testTitle;
  final String accessToken;

  const ResultInputForm({Key? key, required this.testTitle, required this.accessToken}) : super(key: key);

  @override
  _ResultInputFormState createState() => _ResultInputFormState();
}

class _ResultInputFormState extends State<ResultInputForm> {
  final StudentService _studentsService = StudentService();
  final ApiService _resultsService = ApiService();

  List<Student> students = [];
  Map<String, TextEditingController> marksControllers = {};
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchStudents();
  }

  /// Fetches students from API
  Future<void> fetchStudents() async {
    try {
      students = await StudentService.fetchStudents(widget.accessToken);

      // Initialize controllers for marks
      for (var student in students) {
        marksControllers[student.studentCode] = TextEditingController();
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  /// Submits results for all students
  void _submitResults() async {
    List<StudentResult> results = students.map((student) {
      return StudentResult(
        student: student.studentCode,
        resultLock: widget.testTitle,
        subject: "Maths",
        marks: {
          "obtained": int.tryParse(marksControllers[student.studentCode]?.text ?? "0") ?? 0,
          "total": 100,
        },
      );
    }).toList();

    try {
      await _resultsService.postResults(widget.accessToken, results);
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error submitting results: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Enter Marks for ${widget.testTitle}")),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(child: Text(errorMessage!))
              : Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: students.length,
                          itemBuilder: (context, index) {
                            final student = students[index];
                            return Card(
                              child: ListTile(
                                title: Text(student.username),
                                subtitle: Text("Code: ${student.studentCode}"),
                                trailing: SizedBox(
                                  width: 80,
                                  child: TextField(
                                    controller: marksControllers[student.studentCode],
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(labelText: "Marks"),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _submitResults,
                        child: Text("Submit All"),
                      ),
                    ],
                  ),
                ),
    );
  }
}
