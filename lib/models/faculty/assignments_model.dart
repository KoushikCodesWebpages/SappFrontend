class Assignment {
  final String title;
  final String description;
  final String subject;
  final int mark;
  final String standard;
  final String section;
  final String academicYear;
  final DateTime dueDate;
  final String createdBy;

  Assignment({
    required this.title,
    required this.description,
    required this.subject,
    required this.mark,
    required this.standard,
    required this.section,
    required this.academicYear,
    required this.dueDate,
    required this.createdBy,
  });

  // Convert JSON to Assignment object
  factory Assignment.fromJson(Map<String, dynamic> json) {
    return Assignment(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      subject: json['subject'] ?? '',
      mark: json['total_mark'] ?? 0,
      standard: json['standard'] ?? '',
      section: json['section'] ?? '',
      academicYear: json['academic_year'] ?? '',
      dueDate: DateTime.parse(json['due_date'] ?? ''),
      createdBy: json['created_by'] ?? '',
    );
  }

  // Convert Assignment object to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'subject': subject,
      'total_mark': mark,
      'standard': standard,
      'section': section,
      'academic_year': academicYear,
      'due_date': dueDate.toIso8601String(),
      'created_by': createdBy,
    };
  }
}
