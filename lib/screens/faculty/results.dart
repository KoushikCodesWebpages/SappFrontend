import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:eg/config/mapp_config.dart';
import '../../widgets/faculty/result_form.dart';
import '../../models/faculty/result_lock.dart';
import '../../utils/constants.dart';

class FacultyResultsPage extends StatefulWidget {
  final String accessToken;

  const FacultyResultsPage({super.key, required this.accessToken});

  @override
  FacultyResultsPageState createState() => FacultyResultsPageState();
}

class FacultyResultsPageState extends State<FacultyResultsPage> {
  List<ResultLock> lockedTests = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchLockedTests();
  }

  /// Fetches locked tests from the backend
  Future<void> fetchLockedTests() async {
    try {
      final response = await http.get(
        Uri.parse(AppConfig.facResultsLockUrl),
        headers: {
          "Authorization": "Bearer ${widget.accessToken}",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        print(response.body);
        List<dynamic> data = jsonDecode(response.body);
        setState(() {
          lockedTests = data.map((item) => ResultLock.fromJson(item)).toList();
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = "Failed to fetch locked tests: ${response.body}";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "Error fetching locked tests: $e";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.mainColor.withOpacity(0.1),
      appBar: AppBar(
        title: const Text("Faculty Results", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        backgroundColor: AppConstants.mainColor, // Set app color
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
              : lockedTests.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.lock_outline, size: 80, color: AppConstants.mainColor),
                          const SizedBox(height: 10),
                          Text(
                            "No result locks available",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: AppConstants.mainColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListView.builder(
                        itemCount: lockedTests.length,
                        itemBuilder: (context, index) {
                          final test = lockedTests[index];
                          return Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                              title: Text(
                                test.title,
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                "Start: ${test.startDate}\nEnd: ${test.endDate}",
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.edit, color: AppConstants.mainColor),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ResultInputForm(
                                        testTitle: test.title,
                                        accessToken: AppConfig.accessToken,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
    );
  }
}
