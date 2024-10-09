import 'package:flutter/material.dart';
import 'package:chall_mobile/api/api_response.dart';
import 'package:chall_mobile/data/tombola_details_response.dart';
import 'package:chall_mobile/services/ticket_service.dart';
import 'package:chall_mobile/services/tombola_service.dart';
import 'package:chall_mobile/widgets/details_future_builder.dart';
import 'package:chall_mobile/widgets/screen.dart';

class KermesseTombolaDetailsScreen extends StatefulWidget {
  final int kermesseId;
  final int tombolaId;

  const KermesseTombolaDetailsScreen({
    super.key,
    required this.kermesseId,
    required this.tombolaId,
  });

  @override
  State<KermesseTombolaDetailsScreen> createState() =>
      _KermesseTombolaDetailsScreenState();
}

class _KermesseTombolaDetailsScreenState
    extends State<KermesseTombolaDetailsScreen> {
  final TombolaService _tombolaService = TombolaService();
  final TicketService _ticketService = TicketService();

  Future<TombolaDetailsResponse> _get() async {
    ApiResponse<TombolaDetailsResponse> response =
        await _tombolaService.details(
      tombolaId: widget.tombolaId,
    );
    if (response.error != null) {
      throw Exception(response.error);
    }
    return response.data!;
  }

  Future<void> _participate() async {
    ApiResponse<Null> response = await _ticketService.create(
      tombolaId: widget.tombolaId,
    );
    if (response.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.error!),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Participation successful'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Détails de la tombola",
          ),
          DetailsFutureBuilder<TombolaDetailsResponse>(
            future: _get,
            builder: (context, data) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.name),
                  Text(data.price.toString()),
                  Text(data.lot),
                  Text(data.statut),
                  ElevatedButton(
                    onPressed: _participate,
                    child: const Text("Participer"),
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
