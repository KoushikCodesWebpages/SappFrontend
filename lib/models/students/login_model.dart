import '../../config/mapp_config.dart';

class LoginRequest {
  final String email;
  final String password;
  final String role;

  LoginRequest({required this.email, required this.password, required this.role});

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
      "role": role,
    };
  }
}

class LoginResponse {
  final String accessToken;
  final String refreshToken;

  LoginResponse({required this.accessToken, required this.refreshToken});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    AppConfig.accessToken = json["access_token"];
    AppConfig.refreshToken = json["refresh_token"];
    return LoginResponse(
      accessToken: json["access_token"],
      refreshToken: json["refresh_token"],
    );
  }
}
