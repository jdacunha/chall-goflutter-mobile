import 'dart:convert';

class UserDetailsResponse {
  final int id;
  final String name;
  final String email;
  final String role;
  final int jetons;

  UserDetailsResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.jetons,
  });

  factory UserDetailsResponse.fromMap(Map<String, dynamic> json) {
    return UserDetailsResponse(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      jetons: json['jetons'],
    );
  }

  factory UserDetailsResponse.fromJson(String source) {
    return UserDetailsResponse.fromMap(json.decode(source));
  }
}
