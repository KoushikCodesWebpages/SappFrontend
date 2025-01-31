class Announcement {
  final String id;
  final String title;
  final String date;
  final String timings;

  Announcement({
    required this.id,
    required this.title,
    required this.date,
    required this.timings,
  });

  // Factory method to create an object from JSON
  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      id: json['id'],
      title: json['title'],
      date: json['date'],
      timings: json['timings'],
    );
  }
}
