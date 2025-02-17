import 'package:eg/config/mapp_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/faculty/dashboard_details_model.dart';

class FacultyService {
  static const String _apiUrl = AppConfig.facProfileUrl; // API URL from config

  Future<Faculty> fetchFacultyData() async {
    String accessToken = AppConfig.accessToken; // Fetch token from config

    try {
      var response = await http.get(
        Uri.parse(_apiUrl),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );
      print("response $response");

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data);
        return Faculty.fromJson(data);
      } else {
        throw Exception('Failed to load faculty data: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error fetching faculty data: $e');
    }
  }
}
