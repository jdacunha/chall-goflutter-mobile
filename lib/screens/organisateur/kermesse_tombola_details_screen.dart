import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chall_mobile/api/api_response.dart';
import 'package:chall_mobile/data/tombola_details_response.dart';
import 'package:chall_mobile/router/organisateur_routes.dart';
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

  Future<TombolaDetailsResponse> _fetchTombolaDetails() async {
    final response = await _tombolaService.details(
      tombolaId: widget.tombolaId,
    );
    if (response.error != null) {
      throw Exception(response.error);
    }
    return response.data!;
  }

  Future<void> _endTombola() async {
    final response = await _tombolaService.end(tombolaId: widget.tombolaId);

    final message = response.error ?? 'Tombola terminée avec succès';
    _showSnackBar(message, isError: response.error != null);
    if (response.error == null) {
      context.pop();
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red[400] : Colors.green[400],
      ),
    );
  }

  void _navigateToEditTombola() {
    context.push(
      OrganisateurRoutes.kermesseTombolaEdit,
      extra: {
        "kermesseId": widget.kermesseId,
        "tombolaId": widget.tombolaId,
      },
    );
  }

  String _translateStatus(String status) {
    switch (status) {
      case 'STARTED':
        return 'En cours';
      case 'ENDED':
        return 'Terminée';
      default:
        return status;
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
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          DetailsFutureBuilder<TombolaDetailsResponse>(
            future: _fetchTombolaDetails,
            builder: (context, data) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Nom: ${data.name}"),
                  Text("Price: ${data.price}"),
                  Text("Lot: ${data.lot}"),
                  Text("Statut: ${_translateStatus(data.statut)}"),
                  const SizedBox(height: 16),
                  if (data.statut == "STARTED")
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: _navigateToEditTombola,
                          child: const Text("Modifier"),
                        ),
                        ElevatedButton(
                          onPressed: _endTombola,
                          child: const Text("Terminer"),
                        ),
                      ],
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
