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

  Future<InteractionDetailsResponse> _get() async {
    ApiResponse<InteractionDetailsResponse> response =
        await _interactionService.details(
      interactionId: widget.interactionId,
    );
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
            "Détails de l'interaction",
          ),
          DetailsFutureBuilder<InteractionDetailsResponse>(
            future: _get,
            builder: (context, data) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.kermesse.name),
                  Text(data.stand.name),
                  Text(data.type),
                  Text(data.user.name),
                  Text(data.jetons.toString()),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
