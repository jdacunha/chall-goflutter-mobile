import 'dart:convert';

class LoginResponse {
  final int id;
  final String name;
  final String email;
  final String role;
  final String token;
  final bool hasStand;

  LoginResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.token,
    required this.hasStand,
  });

  factory LoginResponse.fromMap(Map<String, dynamic> json) {
    return LoginResponse(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      token: json['token'],
      hasStand: json['has_stand'],
    );
  }

  factory LoginResponse.fromJson(String source) {
    return LoginResponse.fromMap(json.decode(source));
  }
}
