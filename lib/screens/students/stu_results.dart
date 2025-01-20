// import 'package:flutter/material.dart';
// import 'dart:convert'; // For JSON decoding
// import 'package:http/http.dart' as http; // For HTTP requests

// class StuResults extends StatefulWidget {
//   const StuResults({super.key});

//   @override
//   State<StuResults> createState() => _StuResultsState();
// }

// class _StuResultsState extends State<StuResults> {
//   // Variable to store API data
//   Map<String, dynamic>? results;
//   bool isLoading = true;

//   // Fetch data from the Flask API
//   Future<void> fetchResults() async {
//     final url = Uri.parse('http://127.0.0.1:5010/results'); // Update with your Flask server address
//     try {
//       final response = await http.get(url);
//       if (response.statusCode == 200) {
//         setState(() {
//           results = json.decode(response.body)['results'];
//           isLoading = false;
//         });
//       } else {
//         print('Failed to fetch results. Status code: ${response.statusCode}');
//       }
//     } catch (error) {
//       print('Error fetching results: $error');
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     fetchResults();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           backgroundColor: const Color(0xFF759BFC), // Set the background color for the navbar
//           title: const Text(
//             'Student Results',
//             style: TextStyle(color: Colors.white), // White text for the navbar
//           ),
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back, color: Colors.white), // White back arrow
//             onPressed: () {
//               Navigator.pop(context); // Navigate back to the previous screen
//             },
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
//                         // Display Student Name and Grade outside of the main container
//                         Padding(
//                           padding: const EdgeInsets.only(bottom: 8.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 8.0), // Left margin for Name
//                                 child: Text(
//                                   'Name: ${results!['name']}',
//                                   style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(right: 8.0), // Right margin for Grade
//                                 child: Text(
//                                   'Grade: ${results!['grade']}',
//                                   style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         // Main container for the rest of the details
//                         Container(
//                           width: double.infinity, // Full width
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(20), // Rounded edges
//                             border: Border.all(
//                               color: Colors.black.withOpacity(0.1), // Subtle border
//                               width: 1,
//                             ),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.1),
//                                 spreadRadius: 2,
//                                 blurRadius: 5,
//                                 offset: const Offset(0, 3), // Slight shadow
//                               ),
//                             ],
//                           ),
//                           padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
//                           child: SingleChildScrollView(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Padding(
//                                   padding: EdgeInsets.only(bottom: 8.0),
//                                   child: Text(
//                                     'Subject Scores:',
//                                     style: TextStyle(fontSize: 18),
//                                   ),
//                                 ),
//                                 // Custom Table Container
//                                 Container(
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(15),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.black.withOpacity(0.1),
//                                         spreadRadius: 2,
//                                         blurRadius: 6,
//                                         offset: const Offset(0, 3),
//                                       ),
//                                     ],
//                                   ),
//                                   child: Column(
//                                     children: [
//                                       // Table Header
//                                       Container(
//                                         decoration: BoxDecoration(
//                                           color: const Color(0xFF759BFC),
//                                           borderRadius: const BorderRadius.only(
//                                             topLeft: Radius.circular(15),
//                                             topRight: Radius.circular(15),
//                                           ),
//                                         ),
//                                         padding: const EdgeInsets.symmetric(vertical: 10.0),
//                                         child: Row(
//                                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                           children: const [
//                                             Expanded(
//                                               child: Center(
//                                                 child: Text(
//                                                   'Subject',
//                                                   style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                                                 ),
//                                               ),
//                                             ),
//                                             Expanded(
//                                               child: Center(
//                                                 child: Text(
//                                                   'Total Marks',
//                                                   style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                                                 ),
//                                               ),
//                                             ),
//                                             Expanded(
//                                               child: Center(
//                                                 child: Text(
//                                                   'Marks Obtained',
//                                                   style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       // Table Rows with hover effect
//                                       ...results!['subjects'].asMap().entries.map<Widget>((entry) {
//                                         int index = entry.key;
//                                         Map<String, dynamic> subject = entry.value;

//                                         // Determine the background color based on the row index and hover state
//                                         Color rowColor = (index % 2 == 0)
//                                             ? Colors.grey.shade100 // Light gray for even rows
//                                             : Colors.white; // White for odd rows
//                                         if (subject['hover'] == true) {
//                                           rowColor = const Color(0xFFD9E3FC); // Hover color
//                                         }

//                                         return MouseRegion(
//                                           onEnter: (_) {
//                                             setState(() {
//                                               subject['hover'] = true;
//                                             });
//                                           },
//                                           onExit: (_) {
//                                             setState(() {
//                                               subject['hover'] = false;
//                                             });
//                                           },
//                                           child: Container(
//                                             color: rowColor, // Apply the row color based on hover and alternating row logic
//                                             padding: const EdgeInsets.symmetric(vertical: 10.0),
//                                             child: Row(
//                                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                               children: [
//                                                 Expanded(
//                                                   child: Center(
//                                                     child: Text(subject['subject']),
//                                                   ),
//                                                 ),
//                                                 const Expanded(
//                                                   child: Center(
//                                                     child: Text('100'), // Total marks
//                                                   ),
//                                                 ),
//                                                 Expanded(
//                                                   child: Center(
//                                                     child: Text(subject['score'].toString()),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         );
//                                       }).toList(),
//                                     ],
//                                   ),
//                                 ),
//                                 const SizedBox(height: 20), // Space below the table
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       'Total Marks Obtained: ${results!['subjects'].map((subject) => subject['score']).reduce((a, b) => a + b)}',
//                                       style: const TextStyle(fontSize: 16),
//                                     ),
//                                     Text(
//                                       'Actual Total Marks: ${results!['subjects'].length * 100}',
//                                       style: const TextStyle(fontSize: 16),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import '../../services/students/stu_results_service.dart';
import '../../models/students/stu_results_model.dart';

class StuResults extends StatefulWidget {
  const StuResults({super.key});

  @override
  State<StuResults> createState() => _StuResultsPageState();
}

class _StuResultsPageState extends State<StuResults> {
  StudentResults? results;
  bool isLoading = true;

  final StuResultsService _service = StuResultsService();

  @override
  void initState() {
    super.initState();
    fetchResults();
  }

  Future<void> fetchResults() async {
    final fetchedResults = await _service.fetchResults();
    setState(() {
      results = fetchedResults;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF759BFC),
          title: const Text(
            'Student Results',
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : results == null
                ? const Center(child: Text('Failed to load results.'))
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Name: ${results!.name}',
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Grade: ${results!.grade}',
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.black.withOpacity(0.1), width: 1),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Subject Scores:',
                                style: TextStyle(fontSize: 18),
                              ),
                              const SizedBox(height: 10),
                              ...results!.subjects.map((subject) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(subject.subject),
                                      Text(subject.score.toString()),
                                    ],
                                  ),
                                );
                              }).toList(),
                              const Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total Marks Obtained: ${results!.totalScore}',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    'Actual Total Marks: ${results!.subjects.length * 100}',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
