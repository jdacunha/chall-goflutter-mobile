import 'dart:convert';

class TombolaEditRequest {
  final String name;
  final int price;
  final String lot;

  TombolaEditRequest({
    required this.name,
    required this.price,
    required this.lot,
  });

  String toJson() {
    return json.encode({
      'name': name,
      'price': price,
      'lot': lot,
    });
  }
}
