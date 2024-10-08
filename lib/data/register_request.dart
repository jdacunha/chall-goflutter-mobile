import 'dart:convert';

class RegisterRequest {
  final String name;
  final String email;
  final String password;
  final String role;

  RegisterRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.role,
  });

  String toJson() {
    return json.encode({
      'name': name,
      'email': email,
      'password': password,
      'role': role,
    });
  }
}
