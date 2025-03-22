import 'dart:convert';
import '../../config/mapp_config.dart';
import 'package:http/http.dart' as http;
import '../../models/faculty/result_lock.dart';
import '../../models/faculty/result_post.dart';
import '../../utils/constants.dart';

class ApiService {
  static final String apiUrl1 = AppConfig.facResultsLockUrl;
  static final String apiUrl2 = AppConfig.facResultsPostUrl;

  /// Fetches locked tests from the backend
  static Future<List<ResultLock>> fetchLockedTests(String accessToken) async {
    try {
      final response = await http.get(
        Uri.parse(apiUrl1),
        headers: {
          "Authorization": "Bearer $accessToken",
          "Content-Type": "application/json"
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((item) => ResultLock.fromJson(item)).toList();
      } else {
        throw Exception("Failed to fetch locked tests: ${response.body}");
      }
    } catch (e) {
      throw Exception("Failed to fetch locked tests: $e");
    }
  }

  /// Posts student results to the backend
  Future<void> postResults(String accessToken, List<StudentResult> results) async {
    try {
      List<Map<String, dynamic>> payload = results.map((r) => r.toJson()).toList();

      final response = await http.post(
        Uri.parse(apiUrl2),
        headers: {
          "Authorization": "Bearer $accessToken",
          "Content-Type": "application/json"
        },
        body: jsonEncode(payload),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception("Failed to submit results: ${response.body}");
      }
    } catch (e) {
      throw Exception("Failed to submit results: $e");
    }
  }
}
