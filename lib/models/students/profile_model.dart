import 'dart:convert';

class UserProfile {
  final String username;
  final String email;
  final String role;
  final String enrollmentNumber;
  final int standard;
  final String section;
  final List<String> subjects;
  final String academicYear;
  final double attendancePercent;
  final String studentCode;

  UserProfile({
    required this.username,
    required this.email,
    required this.role,
    required this.enrollmentNumber,
    required this.standard,
    required this.section,
    required this.subjects,
    required this.academicYear,
    required this.attendancePercent,
    required this.studentCode,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      username: json['user']['username'],
      email: json['user']['email'],
      role: json['user']['role'],
      enrollmentNumber: json['enrollment_number'],
      standard: json['standard'],
      section: json['section'],
      subjects: List<String>.from(jsonDecode(json['subjects'].replaceAll("'", "\""))),
      academicYear: json['academic_year'],
      attendancePercent: json['attendance_percent'].toDouble(),
      studentCode: json['student_code'],
    );
  }
}
