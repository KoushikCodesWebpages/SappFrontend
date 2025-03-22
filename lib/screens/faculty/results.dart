import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:eg/config/mapp_config.dart';
import 'package:flutter/material.dart';
import '../../widgets/faculty/result_form.dart';
import '../../models/faculty/result_lock.dart';
import '../../services/faculty/results_service.dart';

// class FacultyResultsPage extends StatefulWidget {
//   final String accessToken;

//   const FacultyResultsPage({Key? key, required this.accessToken}) : super(key: key);

//   @override
//   _FacultyResultsPageState createState() => _FacultyResultsPageState();
// }

// class _FacultyResultsPageState extends State<FacultyResultsPage> {
//   List<ResultLock> lockedTests = [];
//   bool isLoading = true;
//   String? errorMessage;

  // @override
  // void initState() {
  //   super.initState();
  //   fetchLockedTests();
  // }

  // /// Fetches locked tests from the backend
  // Future<void> fetchLockedTests() async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse(AppConfig.facResultsLockUrl),
  //       headers: {
  //         "Authorization": "Bearer ${widget.accessToken}",
  //         "Content-Type": "application/json",
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       print(response.body);
  //       List<dynamic> data = jsonDecode(response.body);
  //       setState(() {
  //         lockedTests = data.map((item) => ResultLock.fromJson(item)).toList();
  //         isLoading = false;
  //       });
  //     } else {
  //       setState(() {
  //         errorMessage = "Failed to fetch locked tests: ${response.body}";
  //         isLoading = false;
  //       });
  //     }
  //   } catch (e) {
  //     setState(() {
  //       errorMessage = "Error fetching locked tests: $e";
  //       isLoading = false;
  //     });
  //   }
  // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Faculty Results")),
//       body: isLoading
//           ? Center(child: CircularProgressIndicator())
//           : errorMessage != null
//               ? Center(child: Text(errorMessage!))
//               : ListView.builder(
//                   itemCount: lockedTests.length,
//                   itemBuilder: (context, index) {
//                     final test = lockedTests[index];
//                     return Card(
//                       child: ListTile(
//                         title: Text(test.title),
//                         subtitle: Text("Start: ${test.startDate}, End: ${test.endDate}"),
//                         trailing: IconButton(
//                           icon: Icon(Icons.edit),
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (_) => ResultInputForm(
//                                   testTitle: test.title,
//                                   accessToken: widget.accessToken,
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import '../../widgets/faculty/result_form.dart';
import '../../models/faculty/result_lock.dart';

// class FacultyResultsPage extends StatelessWidget {
//   final String accessToken;
//   final List<ResultLock> lockedTests;

//   const FacultyResultsPage({Key? key, required this.accessToken, required this.lockedTests}) : super(key: key);

  class FacultyResultsPage extends StatefulWidget {
  final String accessToken;

  const FacultyResultsPage({Key? key, required this.accessToken}) : super(key: key);

  @override
  _FacultyResultsPageState createState() => _FacultyResultsPageState();
}

class _FacultyResultsPageState extends State<FacultyResultsPage> {
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
      appBar: AppBar(title: Text("Faculty Results")),
      body: ListView.builder(
        itemCount: lockedTests.length,
        itemBuilder: (context, index) {
          final test = lockedTests[index];
          return Card(
            child: ListTile(
              title: Text(test.title),
              subtitle: Text("Start: ${test.startDate}, End: ${test.endDate}"),
              trailing: IconButton(
                icon: Icon(Icons.edit),
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
    );
  }
}
