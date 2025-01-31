import 'dart:convert';
import 'package:eg/config/mapp_config.dart';
import 'package:http/http.dart' as http;
import '../../models/students/login_model.dart';

class AuthService {

  Future<LoginResponse?> login(LoginRequest request) async {
    final response = await http.post(
      Uri.parse(AppConfig.loginUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      return LoginResponse.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }
}

