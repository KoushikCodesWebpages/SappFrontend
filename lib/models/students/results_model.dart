// class StudentResults {
//   final int studentId;
//   final String name;
//   final List<Subject> subjects;
//   final int totalScore;
//   final String grade;

//   StudentResults({
//     required this.studentId,
//     required this.name,
//     required this.subjects,
//     required this.totalScore,
//     required this.grade,
//   });

//   factory StudentResults.fromJson(Map<String, dynamic> json) {
//     return StudentResults(
//       studentId: json['student_id'],
//       name: json['name'],
//       subjects: (json['subjects'] as List)
//           .map((subject) => Subject.fromJson(subject))
//           .toList(),
//       totalScore: json['total_score'],
//       grade: json['grade'],
//     );
//   }
// }

// class Subject {
//   final String subject;
//   final int score;

//   Subject({required this.subject, required this.score});

//   factory Subject.fromJson(Map<String, dynamic> json) {
//     return Subject(
//       subject: json['subject'],
//       score: json['score'],
//     );
//   }
// }


import 'dart:convert';

class StudentResult {
  final String id;
  final String resultLock;
  final String student;
  final String subject;
  final int obtainedMarks;
  final int totalMarks;
  final double percentage;
  final DateTime lastUpdated;

  StudentResult({
    required this.id,
    required this.resultLock,
    required this.student,
    required this.subject,
    required this.obtainedMarks,
    required this.totalMarks,
    required this.percentage,
    required this.lastUpdated,
  });

  factory StudentResult.fromJson(Map<String, dynamic> json) {
    return StudentResult(
      id: json['id'],
      resultLock: json['result_lock'],
      student: json['student'],
      subject: json['subject'],
      obtainedMarks: json['marks']['obtained'],
      totalMarks: json['marks']['total'],
      percentage: json['percentage'],
      lastUpdated: DateTime.parse(json['last_updated']),
    );
  }

  static List<StudentResult> fromJsonList(String str) {
    final List<dynamic> jsonData = json.decode(str);
    return jsonData.map((e) => StudentResult.fromJson(e)).toList();
  }
}
