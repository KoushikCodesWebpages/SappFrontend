import 'dart:convert';
import 'package:eg/config/mapp_config.dart';
import 'package:http/http.dart' as http;

void main() async {
  String apiUrl = AppConfig.stuTimetable; 

  try {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print("API Response: $data");
    } else {
      print("Failed to fetch data. Status Code: ${response.statusCode}");
    }
  } catch (e) {
    print("Error: $e");
  }
}
