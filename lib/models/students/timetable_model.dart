class Timetable {
  final String academicYear;
  final String standard;
  final String section;
  final String facultyName;
  final Map<String, List<String>> schedule;

  Timetable({
    required this.academicYear,
    required this.standard,
    required this.section,
    required this.facultyName,
    required this.schedule,
  });

  factory Timetable.fromJson(Map<String, dynamic> json) {
    return Timetable(
      academicYear: json["academic_year"] ?? "N/A",
      standard: json["standard"] ?? "N/A",
      section: json["section"] ?? "N/A",
      facultyName: json["faculty_name"] ?? "N/A",
      schedule: {
        "monday": List<String>.from(json["monday"] ?? []),
        "tuesday": List<String>.from(json["tuesday"] ?? []),
        "wednesday": List<String>.from(json["wednesday"] ?? []),
        "thursday": List<String>.from(json["thursday"] ?? []),
        "friday": List<String>.from(json["friday"] ?? []),
      },
    );
  }
}
