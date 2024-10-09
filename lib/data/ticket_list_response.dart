import 'dart:convert';

class TicketUser {
  final int id;
  final String name;
  final String email;
  final String role;

  TicketUser({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  factory TicketUser.fromMap(Map<String, dynamic> json) {
    return TicketUser(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
    );
  }

  factory TicketUser.fromJson(String source) {
    return TicketUser.fromMap(json.decode(source));
  }
}

class TicketTombola {
  final int id;
  final String name;
  final String statut;
  final int price;
  final String lot;

  TicketTombola({
    required this.id,
    required this.name,
    required this.statut,
    required this.price,
    required this.lot,
  });

  factory TicketTombola.fromMap(Map<String, dynamic> json) {
    return TicketTombola(
      id: json['id'],
      name: json['name'],
      statut: json['statut'],
      price: json['price'],
      lot: json['lot'],
    );
  }

  factory TicketTombola.fromJson(String source) {
    return TicketTombola.fromMap(json.decode(source));
  }
}

class TicketKermesse {
  final int id;
  final String name;
  final String description;
  final String statut;

  TicketKermesse({
    required this.id,
    required this.name,
    required this.description,
    required this.statut,
  });

  factory TicketKermesse.fromMap(Map<String, dynamic> json) {
    return TicketKermesse(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      statut: json['statut'],
    );
  }

  factory TicketKermesse.fromJson(String source) {
    return TicketKermesse.fromMap(json.decode(source));
  }
}

class TicketListItem {
  final int id;
  final bool gagnant;
  final DateTime createdAt;
  final TicketUser user;
  final TicketTombola tombola;
  final TicketKermesse kermesse;

  TicketListItem({
    required this.id,
    required this.gagnant,
    required this.createdAt,
    required this.user,
    required this.tombola,
    required this.kermesse,
  });

  factory TicketListItem.fromMap(Map<String, dynamic> json) {
    return TicketListItem(
      id: json['id'],
      gagnant: json['gagnant'],
      createdAt: DateTime.parse(json['created_at']),
      user: TicketUser.fromMap(json['user']),
      tombola: TicketTombola.fromMap(json['tombola']),
      kermesse: TicketKermesse.fromMap(json['kermesse']),
    );
  }

  factory TicketListItem.fromJson(String source) {
    return TicketListItem.fromMap(json.decode(source));
  }
}

class TicketListResponse {
  final List<TicketListItem> tickets;

  TicketListResponse({
    required this.tickets,
  });

  factory TicketListResponse.fromList(List<dynamic> list) {
    return TicketListResponse(
      tickets: list.map((item) => TicketListItem.fromMap(item)).toList(),
    );
  }

  factory TicketListResponse.fromJson(String source) {
    return TicketListResponse.fromList(json.decode(source));
  }
}
