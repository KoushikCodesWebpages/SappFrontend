import 'dart:convert';
import 'package:eg/config/mapp_config.dart';
import 'package:http/http.dart' as http;
import '../../models/students/profile_model.dart';

class ProfileService {

  Future<UserProfile> fetchUserProfile() async {
    final response = await http.get(
      Uri.parse(AppConfig.stuProfileUrl),
      headers: {
        'Authorization': 'Bearer ${AppConfig.accessToken}',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return UserProfile.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load profile');
    }
  }
}
