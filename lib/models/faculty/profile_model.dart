import 'dart:convert';

class FacProfile {
  final String username;
  final String email;
  final String role;
  final String facultyId;
  final String department;
  final String specialization;
  final List<List<String>> coverage;
  final List<String> classTeacher;
  final String image;
  final String lastUpdated;

  FacProfile({
    required this.username,
    required this.email,
    required this.role,
    required this.facultyId,
    required this.department,
    required this.specialization,
    required this.coverage,
    required this.classTeacher,
    required this.lastUpdated,
    required this.image,
  });

  factory FacProfile.fromJson(Map<String, dynamic> json) {
    return FacProfile(
      username: json['user']['username'],
      email: json['user']['email'],
      role: json['user']['role'],
      facultyId: json['faculty_id'],
      department: json['department'],
      specialization: json['specialization'],
      // coverage: List<List<String>>.from(jsonDecode(json['coverage'].replaceAll("'", "\""))),
      // classTeacher: List<String>.from(jsonDecode(json['class_teacher'].replaceAll("'", "\""))),
      //studentCode: json['student_code'],

      // coverage: (json['coverage'] as List<dynamic>)
      //     .map((item) => List<String>.from(item))
      //     .toList(),
      // classTeacher: List<String>.from(json['class_teacher']),
      coverage: (json['coverage'] != null)
          ? (jsonDecode(json['coverage'].replaceAll("'", "\"")) as List<dynamic>)
              .map((item) => List<String>.from(item))
              .toList()
          : [],
      classTeacher: (json['class_teacher'] != null)
          ? List<String>.from(jsonDecode(json['class_teacher'].replaceAll("'", "\"")))
          : [],
      image: json['image']??'',
      lastUpdated: json['last_updated']
    );
  }
}
