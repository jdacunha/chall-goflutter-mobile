import 'dart:convert';

class InteractionUser {
  final int id;
  final String name;
  final String email;
  final String role;

  InteractionUser({
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

  factory InteractionUser.fromJson(String source) {
    return InteractionUser.fromMap(json.decode(source));
  }
}

class InteractionStand {
  final int id;
  final String name;
  final String description;
  final String type;
  final int price;

  InteractionStand({
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

  factory InteractionStand.fromJson(String source) {
    return InteractionStand.fromMap(json.decode(source));
  }
}

class InteractionKermesse {
  final int id;
  final String name;
  final String description;
  final String statut;

  InteractionKermesse({
    required this.id,
    required this.name,
    required this.description,
    required this.statut,
  });

  factory InteractionKermesse.fromMap(Map<String, dynamic> json) {
    return InteractionKermesse(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      statut: json['statut'],
    );
  }

  factory InteractionKermesse.fromJson(String source) {
    return InteractionKermesse.fromMap(json.decode(source));
  }
}

class InteractionDetailsResponse {
  final int id;
  final String type;
  final String statut;
  final int jetons;
  final int points;
  final DateTime createdAt;
  final InteractionUser user;
  final InteractionStand stand;
  final InteractionKermesse kermesse;

  InteractionDetailsResponse({
    required this.id,
    required this.type,
    required this.statut,
    required this.jetons,
    required this.points,
    required this.createdAt,
    required this.user,
    required this.stand,
    required this.kermesse,
  });

  factory InteractionDetailsResponse.fromMap(Map<String, dynamic> json) {
    return InteractionDetailsResponse(
      id: json['id'],
      type: json['type'],
      statut: json['statut'],
      jetons: json['jetons'],
      points: json['points'],
      createdAt: DateTime.parse(json['created_at']),
      user: InteractionUser.fromMap(json['user']),
      stand: InteractionStand.fromMap(json['stand']),
      kermesse: InteractionKermesse.fromMap(json['kermesse']),
    );
  }

  factory InteractionDetailsResponse.fromJson(String source) {
    return InteractionDetailsResponse.fromMap(json.decode(source));
  }
}
