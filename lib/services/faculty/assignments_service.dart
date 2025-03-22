import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/faculty/assignments_model.dart';
import '../../config/mapp_config.dart';

class AssignmentService {
  final String baseUrl = AppConfig.facAssignmentsUrl; // Replace with actual API URL
  String accessToken = AppConfig.accessToken;

  Future<bool> postAssignment(Assignment assignment) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken', // Replace with actual token
        },
        body: jsonEncode(assignment.toJson()),
      );

      if (response.statusCode == 201) {
        return true; // Successfully posted
      } else {
        throw Exception('Failed to post assignment: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
