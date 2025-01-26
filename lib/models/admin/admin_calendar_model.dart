import 'dart:convert';

class CalendarEvent {
  final String id;
  final String title;
  final String description;
  final String eventType;
  final String eventDate;
  final String createdBy;
  final String createdAt;
  final String updatedAt;

  CalendarEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.eventType,
    required this.eventDate,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method to create a CalendarEvent from JSON
  factory CalendarEvent.fromJson(Map<String, dynamic> json) {
    return CalendarEvent(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      eventType: json['event_type'],
      eventDate: json['event_date'],
      createdBy: json['created_by'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  // Convert CalendarEvent object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'event_type': eventType,
      'event_date': eventDate,
      'created_by': createdBy,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  // To handle a list of events
  static List<CalendarEvent> fromJsonList(String jsonString) {
    final data = json.decode(jsonString) as List<dynamic>;
    return data.map((event) => CalendarEvent.fromJson(event)).toList();
  }

  static String toJsonList(List<CalendarEvent> events) {
    final data = events.map((event) => event.toJson()).toList();
    return json.encode(data);
  }
}
