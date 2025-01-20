import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/students/stu_results_model.dart';

class StuResultsService {
  final String apiUrl = 'http://127.0.0.1:5010/results';

  Future<StudentResults?> fetchResults() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body)['results'];
        return StudentResults.fromJson(data);
      } else {
        print('Failed to fetch results. Status code: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Error fetching results: $error');
      return null;
    }
  }
}
