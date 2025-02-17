import 'dart:convert';

class Faculty {
  final String username;
  final String email;
  final String role;
  final String facultyId;
  final String department;
  final String specialization;
  final List<List<String>> coverage;
  final List<String> classTeacher;
  final String? image;

  Faculty({
    required this.username,
    required this.email,
    required this.role,
    required this.facultyId,
    required this.department,
    required this.specialization,
    required this.coverage,
    required this.classTeacher,
    this.image,
  });

  // Factory method to create a Faculty object from JSON
  factory Faculty.fromJson(Map<String, dynamic> json) {
    return Faculty(
      username: json['user']['username'],
      email: json['user']['email'],
      role: json['user']['role'],
      facultyId: json['faculty_id'],
      department: json['department'],
      specialization: json['specialization'],
      //coverage: (jsonDecode(json['coverage']) as List).map((e) => List<String>.from(e)).toList(),
      ////coverage: List<List<String>>.from(jsonDecode(json['coverage'].replaceAll("'","\""))),
          //subjects: List<String>.from(jsonDecode(json['subjects'].replaceAll("'", "\""))),
      ////classTeacher: List<String>.from(jsonDecode(json['class_teacher'])),
      ///
      coverage: (jsonDecode(json['coverage'].replaceAll("'", "\"")) as List)
    .map((e) => List<String>.from(e as List))
    .toList(),
classTeacher: List<String>.from(jsonDecode(json['class_teacher'].replaceAll("'", "\""))),

      image: json['image'],
    );
  }
}
