import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chall_mobile/data/interaction_list_response.dart';
import 'package:chall_mobile/router/organisateur_routes.dart';
import 'package:chall_mobile/services/interaction_service.dart';
import 'package:chall_mobile/widgets/list_future_builder.dart';
import 'package:chall_mobile/widgets/screen_list.dart';

class KermesseInteractionListScreen extends StatefulWidget {
  final int kermesseId;

  const KermesseInteractionListScreen({
    super.key,
    required this.kermesseId,
  });

  @override
  State<KermesseInteractionListScreen> createState() =>
      _KermesseInteractionListScreenState();
}

class _KermesseInteractionListScreenState
    extends State<KermesseInteractionListScreen> {
  final InteractionService _interactionService = InteractionService();

  Future<List<InteractionListItem>> _fetchInteractions() async {
    final response = await _interactionService.list(
      kermesseId: widget.kermesseId,
    );
    if (response.error != null) {
      throw Exception(response.error);
    }
    return response.data!;
  }

  void _navigateToInteractionDetails(InteractionListItem item) {
    context.push(
      OrganisateurRoutes.kermesseInteractionDetails,
      extra: {
        "kermesseId": widget.kermesseId,
        "interactionId": item.id,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenList(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Interactions de la Kermesse",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListFutureBuilder<InteractionListItem>(
              future: _fetchInteractions,
              builder: (context, item) {
                return ListTile(
                  title: Text(item.user.name),
                  subtitle: Text("Jetons: ${item.jetons}"),
                  onTap: () => _navigateToInteractionDetails(item),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
