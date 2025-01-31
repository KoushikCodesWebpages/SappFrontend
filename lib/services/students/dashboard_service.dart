import 'dart:convert';
import 'package:http/http.dart' as http;

class StuDashboardService {
  static const String apiUrl = "http://127.0.0.1:5013/students";

  Future<List<Map<String, dynamic>>> fetchStudentData() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<Map<String, dynamic>>.from(data['students']);
      } else {
        throw Exception("Failed to load students data");
      }
    } catch (e) {
      throw Exception("Error fetching data: $e");
    }
  }
}
