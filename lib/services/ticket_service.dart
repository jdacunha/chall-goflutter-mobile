import 'package:chall_mobile/api/api_response.dart';
import 'package:chall_mobile/api/api_service.dart';
import 'package:chall_mobile/data/ticket_create_request.dart';
import 'package:chall_mobile/data/ticket_details_response.dart';
import 'package:chall_mobile/data/ticket_list_response.dart';

class TicketService {
  final ApiService _apiService = ApiService();

  Future<ApiResponse<List<TicketListItem>>> list() {
    return _apiService.get<List<TicketListItem>>(
      "tickets",
      null,
          (data) => TicketListResponse.fromJson(data).tickets,
    );
  }

  Future<ApiResponse<TicketDetailsResponse>> details({
    required int ticketId,
  }) {
    return _apiService.get<TicketDetailsResponse>(
      "tickets/$ticketId",
      null,
      (data) {
        TicketDetailsResponse ticketDetailsResponse =
          TicketDetailsResponse.fromJson(data);
        return ticketDetailsResponse;
      },
    );
  }

  Future<ApiResponse<Null>> create({
    required int tombolaId,
  }) {
    final body = TicketCreateRequest(tombolaId: tombolaId);

    return _apiService.post(
      "tickets",
      body.toJson(),
          (_) => null,
    );
  }
}
