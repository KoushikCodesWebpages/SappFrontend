class FacultyAttendance {
  final String studentName;
  final String studentClass;
  final int rollNumber;
  final int attendancePercentage;

  FacultyAttendance({
    required this.studentName,
    required this.studentClass,
    required this.rollNumber,
    required this.attendancePercentage,
  });

  // Factory method to create a FacultyAttendance instance from a Map
  factory FacultyAttendance.fromMap(Map<String, dynamic> data) {
    return FacultyAttendance(
      studentName: data['student_name'],
      studentClass: data['class'],
      rollNumber: data['roll_number'],
      attendancePercentage: data['attendance_percentage'],
    );
  }

  // Method to convert a FacultyAttendance instance to a Map
  Map<String, dynamic> toMap() {
    return {
      'student_name': studentName,
      'class': studentClass,
      'roll_number': rollNumber,
      'attendance_percentage': attendancePercentage,
    };
  }
}