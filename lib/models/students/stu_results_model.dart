class StudentResults {
  final int studentId;
  final String name;
  final List<Subject> subjects;
  final int totalScore;
  final String grade;

  StudentResults({
    required this.studentId,
    required this.name,
    required this.subjects,
    required this.totalScore,
    required this.grade,
  });

  factory StudentResults.fromJson(Map<String, dynamic> json) {
    return StudentResults(
      studentId: json['student_id'],
      name: json['name'],
      subjects: (json['subjects'] as List)
          .map((subject) => Subject.fromJson(subject))
          .toList(),
      totalScore: json['total_score'],
      grade: json['grade'],
    );
  }
}

class Subject {
  final String subject;
  final int score;

  Subject({required this.subject, required this.score});

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      subject: json['subject'],
      score: json['score'],
    );
  }
}
