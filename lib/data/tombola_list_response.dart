import 'dart:convert';

class TombolaListItem {
  final int id;
  final int kermesseId;
  final String name;
  final String statut;
  final int price;
  final String lot;

  TombolaListItem({
    required this.id,
    required this.kermesseId,
    required this.name,
    required this.statut,
    required this.price,
    required this.lot,
  });

  factory TombolaListItem.fromMap(Map<String, dynamic> json) {
    return TombolaListItem(
      id: json['id'],
      kermesseId: json['kermesse_id'],
      name: json['name'],
      statut: json['statut'],
      price: json['price'],
      lot: json['lot'],
    );
  }

  factory TombolaListItem.fromJson(String source) {
    return TombolaListItem.fromMap(json.decode(source));
  }
}

class TombolaListResponse {
  final List<TombolaListItem> tombolas;

  TombolaListResponse({
    required this.tombolas,
  });

  factory TombolaListResponse.fromList(List<dynamic> list) {
    return TombolaListResponse(
      tombolas: list.map((item) => TombolaListItem.fromMap(item)).toList(),
    );
  }

  factory TombolaListResponse.fromJson(String source) {
    return TombolaListResponse.fromList(json.decode(source));
  }
}
