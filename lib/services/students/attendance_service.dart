import 'package:eg/config/mapp_config.dart';
import 'package:http/http.dart' as http;
import '../../models/students/attendance_model.dart';

class AttendanceService {
  final String apiUrl = AppConfig.stuAttendanceUrl;
  final String accessToken = AppConfig.accessToken; // Replace with actual token

  Future<List<Attendance>> fetchAttendance() async {
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return Attendance.fromJsonList(response.body);
      } else {
        throw Exception('Failed to load attendance');
      }
    } catch (error) {
      throw Exception('Error fetching attendance: $error');
    }
  }
}
