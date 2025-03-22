import 'dart:convert';
import 'package:eg/config/mapp_config.dart';
import '../../models/students/timetable_model.dart';
import 'package:http/http.dart' as http;
import '../../utils/constants.dart';


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

  // static Future<Map<String, List<String>>> getStandardTimetable(String token) async {
  //   final response = await http.get(
  //     Uri.parse(AppConfig.stuTimetable),
  //     headers: {
  //       "Authorization": "Bearer $token",
  //       "Content-Type": "application/json",
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     Map<String, dynamic> jsonData = json.decode(response.body);
  //     return jsonData.map((key, value) => MapEntry(key, List<String>.from(value)));
  //   } else {
  //     throw Exception("Failed to load standard timetable");
  //   }
  // }

  // static Future<Map<String, Map<String, List<String>>>> getClassTimetables(String token) async {
  //   final response = await http.get(
  //     Uri.parse('${AppConfig.baseUrl}/office/timetables/?standard=${AppConstants.standard}&section=${AppConstants.section}'),
  //     headers: {
  //       "Authorization": "Bearer $token",
  //       "Content-Type": "application/json",
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     Map<String, dynamic> jsonData = json.decode(response.body);
  //     return jsonData.map((key, value) => MapEntry(
  //           key,
  //           (value as Map<String, dynamic>)
  //               .map((day, periods) => MapEntry(day, List<String>.from(periods))),
  //         ));
  //   } else {
  //     throw Exception("Failed to load class timetables");
  //   }
  // }

  static Future<Timetable?> getStandardTimetable(String token) async {
  final response = await http.get(
    Uri.parse(AppConfig.stuTimetable),
    headers: {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    },
  );

  if (response.statusCode == 200) {
    List<dynamic> jsonData = json.decode(response.body);
    if (jsonData.isNotEmpty) {
      return Timetable.fromJson(jsonData[0]); // Assuming first entry is the latest
    }
  }
  return null;
}

static Future<Map<String, Timetable>> getClassTimetables(String token) async {
  Map<String, Timetable> classTimetables = {};

  // Define a list of standard-section pairs you need to fetch
  List<Map<String, String>> classList = [
    {'standard': '7', 'section': 'C'},
    {'standard': '9', 'section': 'C'},
    // {'standard': '11', 'section': 'A'},
    // {'standard': '11', 'section': 'B'},
    // Add more standard-section pairs as needed
  ];

  try {
    for (var entry in classList) {
      String standard = entry['standard']!;
      String section = entry['section']!;

      final response = await http.get(
        Uri.parse('${AppConfig.baseUrl}/office/timetables/?standard=$standard&section=$section'),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        
        if (jsonData.isNotEmpty) {
          classTimetables["$standard-$section"] = Timetable.fromJson(jsonData[0]);
        }
      } else {
        print("Failed to fetch timetable for Standard: $standard, Section: $section");
      }
    }
  } catch (e) {
    print("Error fetching class timetables: $e");
  }

  return classTimetables;
}

}