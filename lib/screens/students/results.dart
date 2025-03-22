// import 'package:eg/utils/constants.dart';
// import 'package:flutter/material.dart';
// import '../../services/students/results_service.dart';
// import '../../models/students/results_model.dart';

// class StuResults extends StatefulWidget {
//   const StuResults({super.key});

//   @override
//   StuResultsState createState() => StuResultsState();
// }

// class StuResultsState extends State<StuResults> {
//   final ResultService _resultService = ResultService();
//   List<StudentResult> results = [];
//   String? _selectedExam;
//   bool isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     fetchResults();
//   }

//   Future<void> fetchResults() async {
//     setState(() => isLoading = true);
//     try {
//       List<StudentResult> fetchedResults = await _resultService.fetchResults();
//       setState(() {
//         results = fetchedResults;
//       });
//     } catch (error) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(error.toString())),
//       );
//     }
//     setState(() => isLoading = false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Student Results', style: TextStyle(color: Colors.white)),
//         backgroundColor: AppConstants.mainColor,
//         iconTheme: IconThemeData(color: Colors.white),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.refresh),
//             onPressed: fetchResults,
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // Text(
//             //   'Select Exam Result',
//             //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromRGBO(117, 155, 252, 1)),
//             // ),
//             SizedBox(height: 20),
//             Container(
//                   padding: EdgeInsets.symmetric(horizontal: 16),
//                   decoration: BoxDecoration(
//                     //color: AppConstants.mainColor,
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(
//                       color: AppConstants.mainColor,
//                       width: 2,
//                     ),
//                   ),
//             child: DropdownButton<String>(
//               isExpanded: true,
//               value: _selectedExam,
//               hint: Text("Select Exam"),
//               onChanged: (String? newValue) {
//                 setState(() {
//                   _selectedExam = newValue!;
//                 });
//               },
//               items: results.map((result) => result.resultLock).toSet().map((exam) {
//                 return DropdownMenuItem<String>(
//                   value: exam,
//                   child: Text(exam),
//                 );
//               }).toList(),
//             ),
//             ),
//             SizedBox(height: 20),
//             isLoading
//                 ? Center(child: CircularProgressIndicator())
//                 : _selectedExam == null
//                     ? Center(child: Text("Select an exam to see results"))
//                     : ResultTable(
//                         examResults: results.where((r) => r.resultLock == _selectedExam).toList(),
//                       ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// class ResultTable extends StatelessWidget {
//   final List<StudentResult> examResults;

//   const ResultTable({super.key, required this.examResults});

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
//             DataColumn(label: Text('Percentage', style: TextStyle(fontWeight: FontWeight.bold))),
//           ],
//           rows: examResults.map((result) {
//             return DataRow(
//               cells: [
//                 DataCell(Text(result.subject)),
//                 DataCell(Center(child: Text(result.totalMarks.toString()))),
//                 DataCell(Center(child: Text(result.obtainedMarks.toString()))),
//                 DataCell(Center(child: Text("${result.percentage}%"))),
//               ],
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }


import 'package:eg/utils/constants.dart';
import 'package:flutter/material.dart';
import '../../services/students/results_service.dart';
import '../../models/students/results_model.dart';

class StuResults extends StatefulWidget {
  const StuResults({super.key});

  @override
  StuResultsState createState() => StuResultsState();
}

class StuResultsState extends State<StuResults> {
  final ResultService _resultService = ResultService();
  List<StudentResult> results = [];
  String? _selectedExam;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchResults();
  }

  Future<void> fetchResults() async {
    setState(() => isLoading = true);
    try {
      List<StudentResult> fetchedResults = await _resultService.fetchResults();
      setState(() {
        results = fetchedResults;
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString())),
      );
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Results', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: AppConstants.mainColor,
        // iconTheme: IconThemeData(color: Colors.white),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.refresh),
        //     onPressed: fetchResults,
        //   ),
        // ],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppConstants.mainColor,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _selectedExam,
                    hint: Text("Select Exam", style: TextStyle(fontSize: 16)),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedExam = newValue!;
                      });
                    },
                    items: results.map((result) => result.resultLock).toSet().map((exam) {
                      return DropdownMenuItem<String>(
                        value: exam,
                        child: Text(exam, style: TextStyle(fontWeight: FontWeight.bold)),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(height: 20),
              isLoading
                  ? Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 10),
                          Text("Fetching results...", style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    )
                  : _selectedExam == null
                      ? Center(
                          child: Text(
                            "Select an exam to see results",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppConstants.mainColor),
                          ),
                        )
                      : AnimatedSwitcher(
                          duration: Duration(milliseconds: 500),
                          child: ResultTable(
                            key: ValueKey<String>(_selectedExam ?? ""),
                            examResults: results.where((r) => r.resultLock == _selectedExam).toList(),
                          ),
                        ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResultTable extends StatelessWidget {
  final List<StudentResult> examResults;

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
          headingRowColor: MaterialStateColor.resolveWith((states) => AppConstants.mainColor.withOpacity(0.2)),
          border: TableBorder.all(width: 1, color: AppConstants.mainColor),
          columns: const [
            DataColumn(label: Text('Subject', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Total', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Marks Obtained', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Percentage', style: TextStyle(fontWeight: FontWeight.bold))),
          ],
          rows: examResults.map((result) {
            return DataRow(
              cells: [
                DataCell(Text(result.subject, style: TextStyle(fontWeight: FontWeight.w500))),
                DataCell(Center(child: Text(result.totalMarks.toString(), style: TextStyle(color: Colors.blueAccent)))),
                DataCell(Center(child: Text(result.obtainedMarks.toString(), style: TextStyle(color: Colors.green)))),
                DataCell(Center(child: Text("${result.percentage}%", style: TextStyle(fontWeight: FontWeight.bold)))),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
