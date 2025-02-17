// import 'package:flutter/material.dart';
// import '../../services/students/results_service.dart';
// import '../../models/students/results_model.dart';

// class StuResults extends StatefulWidget {
//   const StuResults({super.key});

//   @override
//   State<StuResults> createState() => _StuResultsPageState();
// }

// class _StuResultsPageState extends State<StuResults> {
//   StudentResults? results;
//   bool isLoading = true;

//   final StuResultsService _service = StuResultsService();

//   @override
//   void initState() {
//     super.initState();
//     fetchResults();
//   }

//   Future<void> fetchResults() async {
//     final fetchedResults = await _service.fetchResults();
//     setState(() {
//       results = fetchedResults;
//       isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           backgroundColor: const Color(0xFF759BFC),
//           title: const Text(
//             'Student Results',
//             style: TextStyle(color: Colors.white),
//           ),
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back, color: Colors.white),
//             onPressed: () => Navigator.pop(context),
//           ),
//         ),
//         body: isLoading
//             ? const Center(child: CircularProgressIndicator())
//             : results == null
//                 ? const Center(child: Text('Failed to load results.'))
//                 : Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(bottom: 8.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 'Name: ${results!.name}',
//                                 style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                               ),
//                               Text(
//                                 'Grade: ${results!.grade}',
//                                 style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(20),
//                             border: Border.all(color: Colors.black.withOpacity(0.1), width: 1),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.1),
//                                 spreadRadius: 2,
//                                 blurRadius: 5,
//                                 offset: const Offset(0, 3),
//                               ),
//                             ],
//                           ),
//                           padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Text(
//                                 'Subject Scores:',
//                                 style: TextStyle(fontSize: 18),
//                               ),
//                               const SizedBox(height: 10),
//                               ...results!.subjects.map((subject) {
//                                 return Padding(
//                                   padding: const EdgeInsets.symmetric(vertical: 5.0),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(subject.subject),
//                                       Text(subject.score.toString()),
//                                     ],
//                                   ),
//                                 );
//                               }).toList(),
//                               const Divider(),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     'Total Marks Obtained: ${results!.totalScore}',
//                                     style: const TextStyle(fontSize: 16),
//                                   ),
//                                   Text(
//                                     'Actual Total Marks: ${results!.subjects.length * 100}',
//                                     style: const TextStyle(fontSize: 16),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//       ),
//     );
//   }
// }


// import 'package:eg/config/mapp_config.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';

// class StuResults extends StatefulWidget {
//   @override
//   StuResultsState createState() => StuResultsState();
// }

// class StuResultsState extends State<StuResults> {
//   String? _selectedExam = 'Select Exam';
//   Map<String, dynamic> studentResult = {};
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     loadLocalData();
//   }

//   // Fetch data from Flask API and update UI
//   Future<void> fetchResults() async {
//     final response = await http.get(Uri.parse(AppConfig.stuResultsUrl));

//     if (response.statusCode == 200) {
//       final Map<String, dynamic> fetchedData = json.decode(response.body);
//       setState(() {
//         studentResult = fetchedData;
//         isLoading = false;
//         saveLocalData(fetchedData); // Save to local storage
//       });
//     } else {
//       setState(() {
//         isLoading = false;
//         studentResult = {"error": "Failed to load data"};
//       });
//     }
//   }

//   // Load data from local storage
//   Future<void> loadLocalData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? localData = prefs.getString('studentResults');
//     if (localData != null) {
//       setState(() {
//         studentResult = json.decode(localData);
//         isLoading = false;
//       });
//     } else {
//       setState(() {
//         isLoading = false;
//         studentResult = {"error": "No local data available"};
//       });
//     }
//   }

//   // Save data to local storage
//   Future<void> saveLocalData(Map<String, dynamic> data) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString('studentResults', json.encode(data));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Student Result',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: Color.fromRGBO(117, 155, 252, 1),
//         iconTheme: IconThemeData(color: Colors.white),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.refresh),
//             onPressed: () {
//               setState(() {
//                 isLoading = true;
//               });
//               fetchResults(); // Refresh data
//             },
//           ),
//         ],
//       ),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           double padding = constraints.maxWidth > 600 ? 20.0 : 10.0;
//           double fontSize = constraints.maxWidth > 600 ? 24.0 : 18.0;

//           return Padding(
//             padding: EdgeInsets.all(padding),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Text(
//                   'Select Exam Result',
//                   style: TextStyle(
//                     fontSize: fontSize,
//                     fontWeight: FontWeight.bold,
//                     color: Color.fromRGBO(117, 155, 252, 1),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 16),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(
//                       color: Color.fromRGBO(117, 155, 252, 1),
//                       width: 2,
//                     ),
//                   ),
//                   child: DropdownButton<String>(
//                     isExpanded: true,
//                     value: _selectedExam,
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         _selectedExam = newValue!;
//                         if (_selectedExam == 'Exam 1') {
//                           isLoading = true;
//                           fetchResults();
//                         }
//                       });
//                     },
//                     items: <String>['Select Exam', 'Exam 1', 'Exam 2', 'Exam 3', 'Exam 4']
//                         .map<DropdownMenuItem<String>>((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(
//                           value,
//                           style: TextStyle(
//                             color: Color.fromRGBO(117, 155, 252, 1),
//                             fontSize: fontSize,
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//                 SizedBox(height: 40),
//                 isLoading
//                     ? Center(child: CircularProgressIndicator())
//                     : _selectedExam == 'Exam 1'
//                         ? Column(
//                             crossAxisAlignment: CrossAxisAlignment.stretch,
//                             children: [
//                               Container(
//                                 padding: EdgeInsets.all(16),
//                                 decoration: BoxDecoration(
//                                   color: Color.fromRGBO(117, 155, 252, 1),
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                                 child: Text(
//                                   'Exam 1',
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: fontSize,
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(height: 20),
//                               ResultTable(examResults: studentResult['subjects'] ?? {}),
//                               SizedBox(height: 40),
//                               Center(
//                                 child: ElevatedButton(
//                                   onPressed: () {
//                                     // Add your report generation logic here
//                                   },
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Color.fromRGBO(117, 155, 252, 1),
//                                     padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(8),
//                                     ),
//                                   ),
//                                   child: Text(
//                                     'Generate Report',
//                                     style: TextStyle(
//                                       fontSize: fontSize,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           )
//                         : Center(child: Text("Select an exam to see results")),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class ResultTable extends StatelessWidget {
//   final Map<String, dynamic> examResults;

//   ResultTable({required this.examResults});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             spreadRadius: 1,
//             blurRadius: 5,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: DataTable(
//           columnSpacing: 40,
//           columns: const [
//             DataColumn(label: Text('Subject', style: TextStyle(fontWeight: FontWeight.bold))),
//             DataColumn(label: Text('Total', style: TextStyle(fontWeight: FontWeight.bold))),
//             DataColumn(label: Text('Marks Obtained', style: TextStyle(fontWeight: FontWeight.bold))),
//           ],
//           rows: examResults.entries.map((entry) => DataRow(
//             cells: [
//               DataCell(Text(entry.key)),
//               DataCell(Center(child: Text("100"))), // Default total is 100
//               DataCell(Center(child: Text(entry.value.toString()))),
//             ],
//           )).toList(),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StuResults extends StatefulWidget {

  const StuResults({super.key});

  @override
  StuResultsState createState() => StuResultsState();
}

class StuResultsState extends State<StuResults> {
  String? _selectedExam = 'Select Exam';
  Map<String, dynamic> studentResult = {};
  bool isLoading = false; // No need for loading state since data is simulated

  @override
  void initState() {
    super.initState();
    loadLocalData();
  }

  // Simulated exam data
  Map<String, dynamic> simulatedResults = {
    "Exam 1": {
      "subjects": {
        "Math": 95,
        "Science": 88,
        "English": 92,
        "History": 85,
      }
    },
    "Exam 2": {
      "subjects": {
        "Math": 90,
        "Science": 87,
        "English": 89,
        "History": 80,
      }
    },
    "Exam 3": {
      "subjects": {
        "Math": 85,
        "Science": 82,
        "English": 88,
        "History": 78,
      }
    },
    "Exam 4": {
      "subjects": {
        "Math": 80,
        "Science": 75,
        "English": 85,
        "History": 70,
      }
    }
  };

  // Load data from local storage
  Future<void> loadLocalData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? localData = prefs.getString('studentResults');
    if (localData != null) {
      setState(() {
        studentResult = json.decode(localData);
      });
    }
  }

  // Save data to local storage
  Future<void> saveLocalData(Map<String, dynamic> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('studentResults', json.encode(data));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Student Result',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromRGBO(117, 155, 252, 1),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                studentResult = {};
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                    child:
      LayoutBuilder(
        builder: (context, constraints) {
          double padding = constraints.maxWidth > 600 ? 20.0 : 10.0;
          double fontSize = constraints.maxWidth > 600 ? 24.0 : 18.0;

          return Padding(
            padding: EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Select Exam Result',
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(117, 155, 252, 1),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Color.fromRGBO(117, 155, 252, 1),
                      width: 2,
                    ),
                  ),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _selectedExam,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedExam = newValue!;
                        studentResult = simulatedResults[_selectedExam!] ?? {};
                        saveLocalData(studentResult);
                      });
                    },
                    items: <String>['Select Exam', 'Exam 1', 'Exam 2', 'Exam 3', 'Exam 4']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                            color: Color.fromRGBO(117, 155, 252, 1),
                            fontSize: fontSize,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 40),
                studentResult.isEmpty
                    ? Center(child: Text("Select an exam to see results"))
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(117, 155, 252, 1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              _selectedExam!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fontSize,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          if (_selectedExam == 'Exam 1') ResultTable(examResults: studentResult['subjects'] ?? {}),
                          SizedBox(height: 40),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                // Add report generation logic here
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromRGBO(117, 155, 252, 1),
                                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                'Generate Report',
                                style: TextStyle(
                                  fontSize: fontSize,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          );
        },
      ),
      )
    );
  }
}

class ResultTable extends StatelessWidget {
  final Map<String, dynamic> examResults;

  const ResultTable({super.key, required this.examResults});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 40,
          columns: const [
            DataColumn(label: Text('Subject', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Total', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Marks Obtained', style: TextStyle(fontWeight: FontWeight.bold))),
          ],
          rows: examResults.entries.map((entry) => DataRow(
            cells: [
              DataCell(Text(entry.key)),
              DataCell(Center(child: Text("100"))), // Default total is 100
              DataCell(Center(child: Text(entry.value.toString()))),
            ],
          )).toList(),
        ),
      ),
    );
  }
}
