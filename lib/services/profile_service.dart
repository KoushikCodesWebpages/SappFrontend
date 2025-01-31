import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/profile_model.dart';

class ProfileService {
  final String apiUrl;

  ProfileService({required this.apiUrl});

  Future<UserProfile> fetchUserProfile(String accessToken) async {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $accessToken',
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
