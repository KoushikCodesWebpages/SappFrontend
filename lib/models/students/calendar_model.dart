import 'dart:convert';

class Event {
  final String id;
  final String title;
  final String description;
  final String eventType;
  final DateTime eventDate;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.eventType,
    required this.eventDate,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      eventType: json['event_type'],
      eventDate: DateTime.parse(json['event_date']),
    );
  }

  static List<Event> fromJsonList(String jsonString) {
    final List<dynamic> parsedList = jsonDecode(jsonString);
    return parsedList.map((json) => Event.fromJson(json)).toList();
  }
}
