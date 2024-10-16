import 'dart:convert';

class KermesseDetailsResponse {
  final int id;
  final int userId;
  final String name;
  final String description;
  final String statut;

  KermesseDetailsResponse({
    required this.id,
    required this.userId,
    required this.name,
    required this.description,
    required this.statut,
  });

  factory KermesseDetailsResponse.fromMap(Map<String, dynamic> json) {
    return KermesseDetailsResponse(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      description: json['description'],
      statut: json['statut'],
    );
  }

  factory KermesseDetailsResponse.fromJson(String source) {
    return KermesseDetailsResponse.fromMap(json.decode(source));
  }
}
