// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../../models/students/results_model.dart';

// class StuResultsService {
//   final String apiUrl = 'http://127.0.0.1:5010/results';

//   Future<StudentResults?> fetchResults() async {
//     try {
//       final response = await http.get(Uri.parse(apiUrl));
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body)['results'];
//         return StudentResults.fromJson(data);
//       } else {
//         print('Failed to fetch results. Status code: ${response.statusCode}');
//         return null;
//       }
//     } catch (error) {
//       print('Error fetching results: $error');
//       return null;
//     }
//   }
// }


import 'package:eg/config/mapp_config.dart';
import 'package:http/http.dart' as http;
//import 'package:shared_preferences/shared_preferences.dart';
import '../../models/students/results_model.dart';

class ResultService {
  final String apiUrl = AppConfig.stuResultsUrl;

  Future<List<StudentResult>> fetchResults() async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = AppConfig.accessToken;//prefs.getString('access_token');

    // if (accessToken == null) {
    //   throw Exception("Access token not found. Please log in.");
    // }

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        "Authorization": "Bearer $accessToken",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      return StudentResult.fromJsonList(response.body);
    } else {
      throw Exception("Failed to load results");
    }
  }
}
