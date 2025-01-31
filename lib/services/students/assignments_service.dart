import 'dart:convert';
import 'package:http/http.dart' as http;

class StuAssignmentsService {
  final int id;
  final String title;
  final String dueDate;
  final String description;

  StuAssignmentsService({
    required this.id,
    required this.title,
    required this.dueDate,
    required this.description,
  });

  factory StuAssignmentsService.fromJson(Map<String, dynamic> json) {
    return StuAssignmentsService(
      id: json['assignment_id'],
      title: json['title'],
      dueDate: json['due_date'],
      description: json['description'],
    );
  }
}

class AssignmentService {
  static const String _baseUrl = 'http://127.0.0.1:5011';

  Future<List<StuAssignmentsService>> fetchAssignments() async {
    final response = await http.get(Uri.parse('$_baseUrl/assignment'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final List<dynamic> data = json['assignments'];
      return data.map((json) => StuAssignmentsService.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load assignments');
    }
  }
}
