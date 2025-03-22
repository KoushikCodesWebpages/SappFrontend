// models/assignment.dart
class Assignment {
  final String id;
  final String title;
  //final String description;
  final String subject;
  final int mark;
  final String dueDate;
  final String? image;
  final String? document;
  final String standard;
  final String section;
  final String academicYear;
  final bool completed;
  // final String createdBy;
  // final String createdAt;
  // final String updatedAt;
  final String lastUpdated;
  final String faculty;

  Assignment({
    required this.id,
    required this.title,
    //required this.description,
    required this.subject,
    required this.mark,
    required this.dueDate,
    required this.image,
    required this.document,
    required this.standard,
    required this.section,
    required this.academicYear,
    required this.completed,
    // required this.createdBy,
    // required this.createdAt,
    // required this.updatedAt,
    required this.lastUpdated,
    required this.faculty,
  });

  factory Assignment.fromJson(Map<String, dynamic> json) {
    return Assignment(
      id: json['id'],
      title: json['title'],
      //description: json['description'],
      subject: json['subject'],
      mark: json['total_mark'],
      dueDate: json['due_date'],
      image: json['image'],
      document: json['document'],
      standard: json['standard'],
      section: json['section'],
      academicYear: json['academic_year'],
      completed: json['completed'],
      // createdBy: json['created_by'],
      // createdAt: json['created_at'],
      // updatedAt: json['updated_at'],
      
      lastUpdated: json['last_updated'],
      faculty: json['faculty'],
    );
  }
}