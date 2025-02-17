import 'package:eg/config/mapp_config.dart';
import 'package:http/http.dart' as http;
import '../../models/students/calendar_model.dart';

class EventService {

  //EventService({super.key});

  Future<List<Event>> fetchEvents() async {
    final Uri url = Uri.parse(AppConfig.stuCalendarUrl); 

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ${AppConfig.accessToken}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return Event.fromJsonList(response.body);
      } else {
        throw Exception("Failed to load events, Status Code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching events: $e");
    }
  }
}
