import 'dart:convert';
import 'package:eg/config/mapp_config.dart';
import '../../models/students/timetable_model.dart';
import 'package:http/http.dart' as http;


class TimetableService {
  static Future<Timetable?> fetchTimetable(String accessToken) async {
    try {
      final response = await http.get(
        Uri.parse(AppConfig.stuTimetable),
        headers: {
          "Authorization": "Bearer $accessToken",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        //print(response.body);
        if (data.isNotEmpty) {
          return Timetable.fromJson(data[0]); // Taking the latest timetable entry
        }
      }
      return null;
    } catch (e) {
      print("Error fetching timetable: $e");
      return null;
    }
  }
}

