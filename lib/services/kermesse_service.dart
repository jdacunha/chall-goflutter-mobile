import 'package:chall_mobile/api/api_response.dart';
import 'package:chall_mobile/api/api_service.dart';
import 'package:chall_mobile/data/kermesse_create_request.dart';
import 'package:chall_mobile/data/kermesse_details_response.dart';
import 'package:chall_mobile/data/kermesse_edit_request.dart';
import 'package:chall_mobile/data/kermesse_list_response.dart';
import 'package:chall_mobile/data/kermesse_stand_invite_request.dart';
import 'package:chall_mobile/data/kermesse_participant_invite_request.dart';

class KermesseService {
  final ApiService _apiService = ApiService();

  Future<ApiResponse<List<KermesseListItem>>> list() {
    return _apiService.get<List<KermesseListItem>>(
      "kermesses",
      null,
          (data) => KermesseListResponse.fromJson(data).kermesses,
    );
  }

  Future<ApiResponse<KermesseDetailsResponse>> details({
    required int kermesseId,
  }) {
    return _apiService.get<KermesseDetailsResponse>(
      "kermesses/$kermesseId",
      null,
      (data) {
        KermesseDetailsResponse kermesseDetailsResponse =
          KermesseDetailsResponse.fromJson(data);
        return kermesseDetailsResponse;
      },
    );
  }

  Future<ApiResponse<Null>> create({
    required String name,
    required String description,
  }) {
    final body = KermesseCreateRequest(
      name: name,
      description: description,
    );

    return _apiService.post(
      "kermesses",
      body.toJson(),
          (_) => null,
    );
  }

  Future<ApiResponse<Null>> edit({
    required int id,
    required String name,
    required String description,
  }) {
    final body = KermesseEditRequest(
      name: name,
      description: description,
    );

    return _apiService.patch(
      "kermesses/$id",
      body.toJson(),
          (_) => null,
    );
  }

  Future<ApiResponse<Null>> end({required int id}) {
    return _apiService.patch(
      "kermesses/$id/end",
      "",
          (_) => null,
    );
  }

  Future<ApiResponse<Null>> inviteStand({
    required int kermesseId,
    required int standId,
  }) {
    final body = KermesseStandInviteRequest(standId: standId);

    return _apiService.patch(
      "kermesses/$kermesseId/stand",
      body.toJson(),
          (_) => null,
    );
  }

Future<ApiResponse<Null>> inviteParticipant({
  required int kermesseId,
  required int userId,
}) async {
  KermesseParticipantInviteRequest body = KermesseParticipantInviteRequest(
    userId: userId,
  );

  return _apiService.patch(
    "kermesses/$kermesseId/participant",
    body.toJson(),
        (_) => null,
  );
}
}