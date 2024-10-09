import 'dart:convert';

class TombolaCreateRequest {
  final int kermesseId;
  final String name;
  final int price;
  final String lot;

  TombolaCreateRequest({
    required this.kermesseId,
    required this.name,
    required this.price,
    required this.lot,
  });

  String toJson() {
    return json.encode({
      'kermesse_id': kermesseId,
      'name': name,
      'price': price,
      'lot': lot,
    });
  }
}
