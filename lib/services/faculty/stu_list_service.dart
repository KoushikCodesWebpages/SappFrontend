import 'dart:convert';
import 'package:eg/config/mapp_config.dart';
import 'package:http/http.dart' as http;
import '../../models/faculty/stu_list_model.dart';

class StudentService {
  static Future<List<Student>> fetchStudents(String accessToken) async {
    String apiUrl = AppConfig.stuListUrl; // Replace with actual API URL

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Student.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load students');
      }
    } catch (e) {
      throw Exception('Error fetching students: $e');
    }
  }
}
