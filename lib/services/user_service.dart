import 'package:chall_mobile/api/api_response.dart';
import 'package:chall_mobile/api/api_service.dart';
import 'package:chall_mobile/data/user_distribute_jetons_request.dart';
import 'package:chall_mobile/data/user_details_response.dart';
import 'package:chall_mobile/data/user_edit_request.dart';
import 'package:chall_mobile/data/user_invite_request.dart';
import 'package:chall_mobile/data/user_list_response.dart';

class UserService {
  final ApiService _apiService = ApiService();

  Future<ApiResponse<List<UserListItem>>> list({int? kermesseId}) {
    final params = {'kermesse_id': kermesseId?.toString() ?? ''};
    return _getUsers("users", params);
  }

  Future<ApiResponse<List<UserListItem>>> listInviteKermesse({
    required int kermesseId,
  }) {
    return _apiService.get<List<UserListItem>>(
      "kermesses/$kermesseId/users",
      null,
      (data) {
        UserListResponse userListResponse = UserListResponse.fromJson(data);
        return userListResponse.users;
      },
    );
  }

  Future<ApiResponse<List<UserListItem>>> listChildren({int? kermesseId}) {
    Map<String, String> params = {};
    if (kermesseId != null) {
      params['kermesse_id'] = kermesseId.toString();
    }
    return _getUsers("users/children", params);
  }

  Future<ApiResponse<UserDetailsResponse>> details({required int userId}) {
    return _apiService.get<UserDetailsResponse>(
      "users/$userId",
      null,
      (data) {
        UserDetailsResponse userDetailsResponse =
          UserDetailsResponse.fromJson(data);
        return userDetailsResponse;
      },
    );
  }

  Future<ApiResponse<Null>> edit({
    required int userId,
    required String password,
    required String newPassword,
  }) {
    final body = UserEditRequest(
      password: password,
      newPassword: newPassword,
    );
    return _apiService.patch(
      "users/$userId/password",
      body.toJson(),
          (_) => null,
    );
  }

  Future<ApiResponse<Null>> distributeJetons({
    required int childId,
    required int montant,
  }) {
    final body = UserDistributeJetonsRequest(
      childId: childId,
      montant: montant,
    );
    return _apiService.patch(
      "users/distribute",
      body.toJson(),
          (_) => null,
    );
  }

  Future<ApiResponse<Null>> invite({
    required String name,
    required String email,
  }) {
    final body = UserInviteRequest(
      name: name,
      email: email,
    );
    return _apiService.post(
      "users/invite",
      body.toJson(),
          (_) => null,
    );
  }

  // méthode pour récupérer la liste des utilisateurs
  Future<ApiResponse<List<UserListItem>>> _getUsers(
      String endpoint, [
        Map<String, String>? params,
      ]) {
    return _apiService.get<List<UserListItem>>(
      endpoint,
      params,
          (data) => UserListResponse.fromJson(data).users,
    );
  }
}
