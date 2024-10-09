import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chall_mobile/api/api_response.dart';
import 'package:chall_mobile/data/ticket_list_response.dart';
import 'package:chall_mobile/router/enfant_routes.dart';
import 'package:chall_mobile/services/ticket_service.dart';
import 'package:chall_mobile/widgets/list_future_builder.dart';
import 'package:chall_mobile/widgets/screen_list.dart';

class TicketListScreen extends StatefulWidget {
  const TicketListScreen({super.key});

  @override
  State<TicketListScreen> createState() => _TicketListScreenState();
}

class _TicketListScreenState extends State<TicketListScreen> {
  final TicketService _ticketService = TicketService();

  Future<List<TicketListItem>> _getAll() async {
    ApiResponse<List<TicketListItem>> response = await _ticketService.list();
    if (response.error != null) {
      throw Exception(response.error);
    }
    return response.data!;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenList(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Liste de mes tickets",
          ),
          Expanded(
            child: ListFutureBuilder<TicketListItem>(
              future: _getAll,
              builder: (context, item) {
                return ListTile(
                  title: Text(item.gagnant ? 'Gagnant' : 'Perdant'),
                  subtitle: Text(item.user.name),
                  onTap: () {
                    context.push(
                      EnfantRoutes.ticketDetails,
                      extra: {
                        "ticketId": item.id,
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
