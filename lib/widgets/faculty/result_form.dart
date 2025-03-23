import 'package:flutter/material.dart';
import '../../models/faculty/stu_list_model.dart';
import '../../models/faculty/result_post.dart';
import '../../services/faculty/stu_list_service.dart';
import '../../services/faculty/results_service.dart';
import '../../utils/constants.dart'; // Import color constants

class ResultInputForm extends StatefulWidget {
  final String testTitle;
  final String accessToken;

  const ResultInputForm({Key? key, required this.testTitle, required this.accessToken}) : super(key: key);

  @override
  _ResultInputFormState createState() => _ResultInputFormState();
}

class _ResultInputFormState extends State<ResultInputForm> {
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
      backgroundColor: AppConstants.mainColor.withOpacity(0.1),
      appBar: AppBar(
        title: Text(widget.testTitle, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        backgroundColor: AppConstants.mainColor,
        //centerTitle: true,
        elevation: 4,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppConstants.mainColor),
            )
          : errorMessage != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      errorMessage!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: students.length,
                          itemBuilder: (context, index) {
                            final student = students[index];
                            return Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                title: Text(
                                  student.username,
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                trailing: SizedBox(
                                  width: 80,
                                  child: TextField(
                                    controller: marksControllers[student.studentCode],
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      labelText: "Marks",
                                      labelStyle: TextStyle(color: Colors.grey[600]),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(color: Colors.grey[400]!),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(color: AppConstants.mainColor),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppConstants.mainColor,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: _submitResults,
                          child: const Text(
                            "Submit All",
                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
