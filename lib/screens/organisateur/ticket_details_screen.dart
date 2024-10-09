import 'package:flutter/material.dart';
import 'package:chall_mobile/data/ticket_details_response.dart';
import 'package:chall_mobile/services/ticket_service.dart';
import 'package:chall_mobile/widgets/details_future_builder.dart';
import 'package:chall_mobile/widgets/screen.dart';

class TicketDetailsScreen extends StatefulWidget {
  final int ticketId;

  const TicketDetailsScreen({
    super.key,
    required this.ticketId,
  });

  @override
  State<TicketDetailsScreen> createState() => _TicketDetailsScreenState();
}

class _TicketDetailsScreenState extends State<TicketDetailsScreen> {
  final TicketService _ticketService = TicketService();

  Future<TicketDetailsResponse> _fetchTicketDetails() async {
    final response = await _ticketService.details(ticketId: widget.ticketId);
    if (response.error != null) {
      throw Exception(response.error);
    }
    return response.data!;
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Détails du ticket",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          DetailsFutureBuilder<TicketDetailsResponse>(
            future: _fetchTicketDetails,
            builder: (context, data) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Tombola: ${data.tombola.name}"),
                  Text("Participant: ${data.user.name}"),
                  Text("Résultat: ${data.gagnant ? 'Gagnant' : 'Perdant'}"),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
