import 'dart:convert';

class TombolaDetailsResponse {
  final int id;
  final int kermesseId;
  final String name;
  final String statut;
  final int price;
  final String lot;

  TombolaDetailsResponse({
    required this.id,
    required this.kermesseId,
    required this.name,
    required this.statut,
    required this.price,
    required this.lot,
  });

  factory TombolaDetailsResponse.fromMap(Map<String, dynamic> json) {
    return TombolaDetailsResponse(
      id: json['id'],
      kermesseId: json['kermesse_id'],
      name: json['name'],
      statut: json['statut'],
      price: json['price'],
      lot: json['lot'],
    );
  }

  factory TombolaDetailsResponse.fromJson(String source) {
    return TombolaDetailsResponse.fromMap(json.decode(source));
  }
}
