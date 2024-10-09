import 'package:chall_mobile/api/api_response.dart';
import 'package:chall_mobile/api/api_service.dart';
import 'package:chall_mobile/data/interaction_create_request.dart';
import 'package:chall_mobile/data/interaction_details_response.dart';
import 'package:chall_mobile/data/interaction_end_request.dart';
import 'package:chall_mobile/data/interaction_list_response.dart';

class InteractionService {
  final ApiService _apiService = ApiService();

  Future<ApiResponse<List<InteractionListItem>>> list({int? kermesseId}) {
    final params = {'kermesse_id': kermesseId?.toString() ?? ''};

    return _apiService.get<List<InteractionListItem>>(
      "interactions",
      params,
          (data) => InteractionListResponse.fromJson(data).interactions,
    );
  }

  Future<ApiResponse<InteractionDetailsResponse>> details({
    required int interactionId,
  }) {
    return _apiService.get<InteractionDetailsResponse>(
      "interactions/$interactionId",
      null,
      (data) {
        InteractionDetailsResponse interactionDetailsResponse =
          InteractionDetailsResponse.fromJson(data);
        return interactionDetailsResponse;
      },
    );
  }

  Future<ApiResponse<Null>> create({
    required int kermesseId,
    required int standId,
    required int quantity,
  }) {
    final body = InteractionCreateRequest(
      kermesseId: kermesseId,
      standId: standId,
      quantity: quantity,
    );

    return _apiService.post(
      "interactions",
      body.toJson(),
          (_) => null,
    );
  }

  Future<ApiResponse<Null>> end({
    required int interactionId,
    required int points,
  }) {
    final body = InteractionEndRequest(points: points);

    return _apiService.patch(
      "interactions/$interactionId",
      body.toJson(),
          (_) => null,
    );
  }
}
