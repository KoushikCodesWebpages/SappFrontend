class AttendanceRecord {
  final String date;
  final String status;

  AttendanceRecord({required this.date, required this.status});

  factory AttendanceRecord.fromJson(Map<String, dynamic> json) {
    return AttendanceRecord(
      date: json['date'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'status': status,
    };
  }
}

class AttendanceResponse {
  final List<AttendanceRecord> attendance;

  AttendanceResponse({required this.attendance});

  factory AttendanceResponse.fromJson(Map<String, dynamic> json) {
    return AttendanceResponse(
      attendance: (json['attendance'] as List)
          .map((item) => AttendanceRecord.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'attendance': attendance.map((record) => record.toJson()).toList(),
    };
  }
}
