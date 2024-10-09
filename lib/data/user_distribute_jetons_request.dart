import 'dart:convert';

class UserDistributeJetonsRequest {
  final int childId;
  final int montant;

  UserDistributeJetonsRequest({
    required this.childId,
    required this.montant,
  });

  String toJson() {
    return json.encode({
      'child_id': childId,
      'montant': montant,
    });
  }
}
