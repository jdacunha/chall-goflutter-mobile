import 'dart:convert';

class KermesseParticipantInviteRequest {
  final int userId;

  KermesseParticipantInviteRequest({
    required this.userId,
  });

  String toJson() {
    return json.encode({
      'user_id': userId,
    });
  }
}
