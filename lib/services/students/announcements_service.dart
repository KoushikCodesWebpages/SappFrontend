import 'dart:convert';
import 'package:eg/config/mapp_config.dart';
import 'package:http/http.dart' as http;
import '../../models/students/announcements_model.dart';

class AnnouncementService {
  final String apiUrl = AppConfig.stuAnnouncementsUrl; 
  final String accessToken = AppConfig.accessToken; 

  // Future<Announcement?> fetchAnnouncement() async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse(apiUrl),
  //       headers: {
  //         'Authorization': 'Bearer $accessToken',
  //         'Content-Type': 'application/json',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       //var jsonData = jsonDecode(response.body);
  //       List<Announcement> announcementList = (jsonDecode(response.body) as List)
  //   .map((item) => Announcement.fromJson(item))
  //   .toList();

  //       return Announcement.fromJson(announcementList);
  //     } else {
  //       print("Error: ${response.statusCode}, ${response.body}");
  //       return null;
  //     }
  //   } catch (e) {
  //     print("Exception: $e");
  //     return null;
  //   }
  // }

  Future<List<Announcement>?> fetchAnnouncements() async {
  try {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List<Announcement> announcementList = (jsonDecode(response.body) as List)
          .map((item) => Announcement.fromJson(item))
          .toList();

      return announcementList;
    } else {
      print("Error: ${response.statusCode}, ${response.body}");
      return null;
    }
  } catch (e) {
    print("Exception: $e");
    return null;
  }
}

}
