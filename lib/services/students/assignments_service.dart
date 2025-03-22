import 'dart:convert';
import 'package:eg/config/mapp_config.dart';
import 'package:http/http.dart' as http;
import '../../models/students/assignments_model.dart';

class AssignmentService {
  final String accessToken;

  AssignmentService({required this.accessToken});

  Future<List<Assignment>> fetchAssignments() async {
    final response = await http.get(
      Uri.parse(AppConfig.stuAssignmentsUrl),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => Assignment.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load assignments');
    }
  }

}