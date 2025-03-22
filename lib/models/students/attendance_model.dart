import 'dart:convert';

class Attendance {
  final int id;
  final String student;
  final DateTime date;
  final String status;
  final DateTime lastUpdated;

  Attendance({
    required this.id,
    required this.student,
    required this.date,
    required this.status,
    required this.lastUpdated,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      id: json['id'],
      student: json['student'],
      date: DateTime.parse(json['date']),
      status: json['status'],
      lastUpdated: DateTime.parse(json['last_updated']),
    );
  }

  static List<Attendance> fromJsonList(String jsonString) {
    final List<dynamic> data = json.decode(jsonString);
    return data.map((e) => Attendance.fromJson(e)).toList();
  }
}
