class StudentResult {
  final String student;
  final String resultLock;
  final String subject;
  final Map<String, int> marks;

  StudentResult({
    required this.student,
    required this.resultLock,
    required this.subject,
    required this.marks,
  });

  Map<String, dynamic> toJson() {
    return {
      "student": student,
      "result_lock": resultLock,
      "subject": subject,
      "marks": marks,
    };
  }
}
