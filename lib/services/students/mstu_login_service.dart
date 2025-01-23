import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../config/mapp_config.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class StuLoginService {

   Future<String> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(AppConfig.loginUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final accessToken = data['access'];
      //await saveToken(accessToken);
      return accessToken;
    } else {
      throw Exception('Failed to log in');
    }
   }

  // Future<void> saveToken(String token) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('access_token', token);
  // }

  // Future<String?> getToken() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString('access_token');
  // }
}
