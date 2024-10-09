import 'dart:convert';

class KermesseListItem {
  final int id;
  final int userId;
  final String name;
  final String description;
  final String statut;

  const KermesseListItem({
    required this.id,
    required this.userId,
    required this.name,
    required this.description,
    required this.statut,
  });

  factory KermesseListItem.fromMap(Map<String, dynamic> json) {
    return KermesseListItem(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      description: json['description'],
      statut: json['statut'],
    );
  }

  factory KermesseListItem.fromJson(String source) =>
      KermesseListItem.fromMap(json.decode(source));
}

class KermesseListResponse {
  final List<KermesseListItem> kermesses;

  const KermesseListResponse({
    required this.kermesses,
  });

  factory KermesseListResponse.fromList(List<dynamic> list) {
    return KermesseListResponse(
      kermesses: list
          .map((item) => KermesseListItem.fromMap(item as Map<String, dynamic>))
          .toList(),
    );
  }

  factory KermesseListResponse.fromJson(String source) =>
      KermesseListResponse.fromList(json.decode(source));
}
