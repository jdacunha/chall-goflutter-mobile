import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chall_mobile/api/api_response.dart';
import 'package:chall_mobile/data/interaction_list_response.dart';
import 'package:chall_mobile/router/enfant_routes.dart';
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

  Future<List<InteractionListItem>> _getAll() async {
    ApiResponse<List<InteractionListItem>> response =
        await _interactionService.list(
      kermesseId: widget.kermesseId,
    );
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
            "Liste des interactions",
          ),
          Expanded(
            child: ListFutureBuilder<InteractionListItem>(
              future: _getAll,
              builder: (context, item) {
                return ListTile(
                  title: Text(item.user.name),
                  subtitle: Text(item.jetons.toString()),
                  onTap: () {
                    context.push(
                      EnfantRoutes.kermesseInteractionDetails,
                      extra: {
                        "kermesseId": widget.kermesseId,
                        "interactionId": item.id,
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
