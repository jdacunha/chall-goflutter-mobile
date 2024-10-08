import 'dart:convert';

class AuthUser {
  final int id;
  final String name;
  final String email;
  final String role;
  final bool hasStand;

  AuthUser({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.hasStand,
  });

  factory AuthUser.getEmpty() {
    return AuthUser(
      id: -1,
      name: '',
      email: '',
      role: '',
      hasStand: false,
    );
  }

  factory AuthUser.fromMap(Map<String, dynamic> json) {
    return AuthUser(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      hasStand: json['has_stand'],
    );
  }

  factory AuthUser.fromJson(String source) {
    return AuthUser.fromMap(json.decode(source));
  }

  AuthUser copyWith({
    int? id,
    String? name,
    String? email,
    String? role,
    bool? hasStand,
  }) {
    return AuthUser(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      hasStand: hasStand ?? this.hasStand,
    );
  }
}
