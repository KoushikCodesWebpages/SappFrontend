import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/notifications_model.dart';

class NotificationsService {
  static const String _apiUrl = 'http://127.0.0.1:5007/notify';

  Future<List<Mail>> fetchMails() async {
    try {
      final response = await http.get(Uri.parse(_apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> mailList = data['mails'];
        return mailList.map((json) => Mail.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load mails');
      }
    } catch (e) {
      print('Error fetching mails: $e');
      return [];
    }
  }
}
