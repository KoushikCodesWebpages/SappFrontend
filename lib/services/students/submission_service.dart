import 'dart:typed_data';
import 'dart:convert';
import 'package:eg/config/mapp_config.dart';
import 'package:http/http.dart' as http;

class AssignmentService {
  Future<bool> submitAssignment(
    String token,
    Map<String, dynamic> assignmentData,
    Uint8List? imageBytes,
    String? imageName,
    Uint8List? documentBytes,
    String? documentName,
  ) async {
    var uri = Uri.parse(AppConfig.stuSubmissionUrl);

    var request = http.MultipartRequest("POST", uri);
    request.headers['Authorization'] = "Bearer $token";
    
    request.fields.addAll(assignmentData.map((key, value) => MapEntry(key, value.toString())));

    if (imageBytes != null && imageName != null) {
      request.files.add(http.MultipartFile.fromBytes("image", imageBytes, filename: imageName));
    }

    if (documentBytes != null && documentName != null) {
      request.files.add(http.MultipartFile.fromBytes("document", documentBytes, filename: documentName));
    }

    var response = await request.send();
    return response.statusCode == 201;
  }

  Future<List<dynamic>> getSubmissions(String accessToken, String assignmentId) async {
    final url = Uri.parse(AppConfig.stuSubmissionUrl);

    final response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer $accessToken",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print("Failed to fetch submissions: ${response.body}");
      return [];
    }
  }
}
