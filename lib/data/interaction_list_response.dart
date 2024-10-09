import 'dart:convert';

class InteractionUser {
  final int id;
  final String name;
  final String email;
  final String role;

  const InteractionUser({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  factory InteractionUser.fromMap(Map<String, dynamic> json) {
    return InteractionUser(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
    );
  }

  factory InteractionUser.fromJson(String source) =>
      InteractionUser.fromMap(json.decode(source));
}

class InteractionStand {
  final int id;
  final String name;
  final String description;
  final String type;
  final int price;

  const InteractionStand({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.price,
  });

  factory InteractionStand.fromMap(Map<String, dynamic> json) {
    return InteractionStand(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      type: json['type'],
      price: json['price'],
    );
  }

  factory InteractionStand.fromJson(String source) =>
      InteractionStand.fromMap(json.decode(source));
}

class InteractionListItem {
  final int id;
  final String type;
  final String statut;
  final int jetons;
  final int points;
  final DateTime createdAt;
  final InteractionUser user;
  final InteractionStand stand;

  const InteractionListItem({
    required this.id,
    required this.type,
    required this.statut,
    required this.jetons,
    required this.points,
    required this.createdAt,
    required this.user,
    required this.stand,
  });

  factory InteractionListItem.fromMap(Map<String, dynamic> json) {
    return InteractionListItem(
      id: json['id'],
      type: json['type'],
      statut: json['statut'],
      jetons: json['jetons'],
      points: json['points'],
      createdAt: DateTime.parse(json['created_at']),
      user: InteractionUser.fromMap(json['user']),
      stand: InteractionStand.fromMap(json['stand']),
    );
  }

  factory InteractionListItem.fromJson(String source) =>
      InteractionListItem.fromMap(json.decode(source));
}

class InteractionListResponse {
  final List<InteractionListItem> interactions;

  const InteractionListResponse({required this.interactions});

  factory InteractionListResponse.fromList(List<dynamic> list) {
    return InteractionListResponse(
      interactions: list
          .map((item) => InteractionListItem.fromMap(item as Map<String, dynamic>))
          .toList(),
    );
  }

  factory InteractionListResponse.fromJson(String source) =>
      InteractionListResponse.fromList(json.decode(source));
}
