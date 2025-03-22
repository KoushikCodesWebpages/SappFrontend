class Student {
  final String studentCode;
  final String username;

  Student({
    required this.studentCode,
    required this.username,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      studentCode: json['student_code'],
      username: json['user__username'],
    );
  }
}
