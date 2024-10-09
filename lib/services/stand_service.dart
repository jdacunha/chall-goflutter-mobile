import 'package:chall_mobile/api/api_response.dart';
import 'package:chall_mobile/api/api_service.dart';
import 'package:chall_mobile/data/stand_create_request.dart';
import 'package:chall_mobile/data/stand_details_response.dart';
import 'package:chall_mobile/data/stand_edit_request.dart';
import 'package:chall_mobile/data/stand_list_response.dart';

class StandService {
  final ApiService _apiService = ApiService();

  Future<ApiResponse<List<StandListItem>>> list({
    int? kermesseId,
    bool? isLibre,
  }) {
    final params = <String, String>{};
    if (kermesseId != null) {
      params['kermesse_id'] = kermesseId.toString();
    }
    if (isLibre != null) {
      params['is_libre'] = isLibre.toString();
    }

    return _apiService.get<List<StandListItem>>(
      "stands",
      params,
          (data) => StandListResponse.fromJson(data).stands,
    );
  }

  Future<ApiResponse<StandDetailsResponse>> details({required int standId}) {
    return _apiService.get<StandDetailsResponse>(
      "stands/$standId",
      null,
      (data) {
        StandDetailsResponse standDetailsResponse =
          StandDetailsResponse.fromJson(data);
        return standDetailsResponse;
      },
    );
  }

  Future<ApiResponse<StandDetailsResponse>> current() {
    return _apiService.get<StandDetailsResponse>(
      "stands/actuel",
      null,
      (data) {
        StandDetailsResponse standDetailsResponse =
          StandDetailsResponse.fromJson(data);
        return standDetailsResponse;
      },
    );
  }

  Future<ApiResponse<Null>> create({
    required String type,
    required String name,
    required String description,
    required int price,
    required int stock,
  }) {
    final body = StandCreateRequest(
      type: type,
      name: name,
      description: description,
      price: price,
      stock: stock,
    );

    return _apiService.post(
      "stands",
      body.toJson(),
          (_) => null,
    );
  }

  Future<ApiResponse<Null>> edit({
    required String name,
    required String description,
    required int price,
    required int stock,
  }) {
    final body = StandEditRequest(
      name: name,
      description: description,
      price: price,
      stock: stock,
    );

    return _apiService.patch(
      "stands",
      body.toJson(),
          (_) => null,
    );
  }
}
