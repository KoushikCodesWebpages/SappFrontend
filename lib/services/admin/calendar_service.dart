import 'package:http/http.dart' as http;
import 'dart:convert';

class AdminCalendarService {
  final String apiUrl = 'http://127.0.0.1:5014/calender';

  Future<Map<DateTime, List>> fetchEvents(DateTime day) async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final events = <DateTime, List>{};

        // Parse and organize events by date
        for (var event in data['calendar']) {
          DateTime eventDate = DateTime.parse(event['date']);
          if (eventDate.year == day.year &&
              eventDate.month == day.month &&
              eventDate.day == day.day) {
            events[day] = events[day] ?? [];
            events[day]?.add(event);
          }
        }
        return events;
      } else {
        throw Exception('Failed to load events');
      }
    } catch (e) {
      print('Error fetching events: $e');
      return {};
    }
  }
}
