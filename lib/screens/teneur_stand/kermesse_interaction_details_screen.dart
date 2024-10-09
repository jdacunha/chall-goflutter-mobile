import 'package:flutter/material.dart';
import 'package:chall_mobile/api/api_response.dart';
import 'package:chall_mobile/data/interaction_details_response.dart';
import 'package:chall_mobile/services/interaction_service.dart';
import 'package:chall_mobile/widgets/details_future_builder.dart';
import 'package:chall_mobile/widgets/number_input.dart';
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
  final TextEditingController _pointController = TextEditingController();

  Future<InteractionDetailsResponse> _fetchInteractionDetails() async {
    final response = await _interactionService.details(
      interactionId: widget.interactionId,
    );
    if (response.error != null) {
      _showSnackBar(response.error!, isError: true);
      throw Exception(response.error);
    }
    return response.data!;
  }

  Future<void> _endInteraction() async {
    final points = int.tryParse(_pointController.text) ?? 0;
    final response = await _interactionService.end(
      interactionId: widget.interactionId,
      points: points,
    );
    if (response.error != null) {
      _showSnackBar(response.error!, isError: true);
    } else {
      _showSnackBar('Interaction terminée avec succès');
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

  Widget _buildInteractionDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildEndInteractionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NumberInput(
          controller: _pointController,
          defaultValue: "0",
          hintText: "Points",
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: _endInteraction,
          child: const Text("End"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
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
                  _buildInteractionDetail("Kermesse", data.kermesse.name),
                  _buildInteractionDetail("Stand", data.stand.name),
                  _buildInteractionDetail("Type", data.type),
                  _buildInteractionDetail("Participant", data.user.name),
                  _buildInteractionDetail("Jetons", data.jetons.toString()),
                  if (data.type == "ACTIVITE")
                    _buildInteractionDetail("Statut", data.statut),
                  const SizedBox(height: 16),
                  if (data.type == "ACTIVITE" && data.statut == "STARTED")
                    _buildEndInteractionSection(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pointController.dispose();
    super.dispose();
  }
}
