import 'package:flutter/material.dart';
import 'package:chall_mobile/api/api_response.dart';
import 'package:chall_mobile/data/interaction_details_response.dart';
import 'package:chall_mobile/services/interaction_service.dart';
import 'package:chall_mobile/widgets/details_future_builder.dart';
import 'package:chall_mobile/widgets/screen.dart';

class KermesseInteractionDetailsScreen extends StatefulWidget {
  final int kermesseId;
  final int interactionId;

  const KermesseInteractionDetailsScreen({
    super.key,
    required this.kermesseId,
    required this.interactionId,
  });

  @override
  State<KermesseInteractionDetailsScreen> createState() =>
      _KermesseInteractionDetailsScreenState();
}

class _KermesseInteractionDetailsScreenState
    extends State<KermesseInteractionDetailsScreen> {
  final InteractionService _interactionService = InteractionService();

  Future<InteractionDetailsResponse> _fetchInteractionDetails() async {
    final response = await _interactionService.details(
      interactionId: widget.interactionId,
    );
    if (response.error != null) {
      throw Exception('Erreur lors de la récupération des détails de l\'interaction: ${response.error}');
    }
    return response.data!;
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Détails de l'interaction",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              DetailsFutureBuilder<InteractionDetailsResponse>(
                future: _fetchInteractionDetails,
                builder: (context, data) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow("Kermesse:", data.kermesse.name),
                      _buildDetailRow("Stand:", data.stand.name),
                      _buildDetailRow("Type:", data.type),
                      _buildDetailRow("Participant:", data.user.name),
                      _buildDetailRow("Jetons:", data.jetons.toString()),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            "$label ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }
}
