import 'package:chall_mobile/api/api_response.dart';
import 'package:chall_mobile/api/api_service.dart';
import 'package:chall_mobile/data/get_me_response.dart';
import 'package:chall_mobile/data/login_request.dart';
import 'package:chall_mobile/data/login_response.dart';
import 'package:chall_mobile/data/register_request.dart';

class AuthService {
  final ApiService _apiService = ApiService();

  Future<ApiResponse<Null>> register({
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    final body = RegisterRequest(
      name: name,
      email: email,
      password: password,
      role: role,
    );

    return _apiService.post(
      "register",
      body.toJson(),
          (_) => null,
    );
  }

  Future<ApiResponse<LoginResponse>> login({
    required String email,
    required String password,
  }) async {
    final body = LoginRequest(
      email: email,
      password: password,
    );

    return _apiService.post(
      "login",
      body.toJson(),
      (data) {
        LoginResponse loginResponse = LoginResponse.fromJson(data);
        return loginResponse;
      },
    );
  }

  Future<ApiResponse<GetMeResponse>> getMe() async {
    return _apiService.get<GetMeResponse>(
      "me",
      null,
      (data) {
        GetMeResponse getMeResponse = GetMeResponse.fromJson(data);
        return getMeResponse;
      },
    );
  }
}
