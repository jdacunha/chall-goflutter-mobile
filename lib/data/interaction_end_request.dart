import 'dart:convert';

class InteractionEndRequest {
  final int points;

  InteractionEndRequest({
    required this.points,
  });

  String toJson() {
    return json.encode({
      'points': points,
    });
  }
}
