import 'dart:convert';
import 'package:eg/config/mapp_config.dart';
import 'package:http/http.dart' as http;
import '../../models/students/portions_model.dart';

class PortionService {
  static Future<List<Portion>> fetchPortions(String accessToken) async {
    String url = AppConfig.stuPortionsUrl; // Replace with actual API endpoint

    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Authorization": "Bearer $accessToken",
        "Content-Type": "application/json"
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      print("Portions");
      print(response.body);
      return jsonData.map((data) => Portion.fromJson(data)).toList();
    } else {
      throw Exception("Failed to load portions");
    }
  }
}
