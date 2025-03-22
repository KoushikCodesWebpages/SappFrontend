class ResultLock {
  final int id;
  final String title;
  final String startDate;
  final String endDate;
  final String lastUpdated;
  final bool isActive;

  ResultLock({
    required this.id,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.lastUpdated,
    required this.isActive,
  });

  factory ResultLock.fromJson(Map<String, dynamic> json) {
    return ResultLock(
      id: json['id'],
      title: json['title'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      lastUpdated: json['last_updated'],
      isActive: json['is_active'],
    );
  }
}
