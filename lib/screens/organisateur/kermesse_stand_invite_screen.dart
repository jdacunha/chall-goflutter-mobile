import 'package:flutter/material.dart';
import 'package:chall_mobile/data/stand_list_response.dart';
import 'package:chall_mobile/services/kermesse_service.dart';
import 'package:chall_mobile/services/stand_service.dart';
import 'package:chall_mobile/widgets/list_future_builder.dart';
import 'package:chall_mobile/widgets/screen_list.dart';
import 'package:go_router/go_router.dart';

class KermesseStandInviteScreen extends StatefulWidget {
  final int kermesseId;

  const KermesseStandInviteScreen({
    super.key,
    required this.kermesseId,
  });

  @override
  State<KermesseStandInviteScreen> createState() =>
      _KermesseStandInviteScreenState();
}

class _KermesseStandInviteScreenState extends State<KermesseStandInviteScreen> {
  final StandService _standService = StandService();
  final KermesseService _kermesseService = KermesseService();

  Future<List<StandListItem>> _fetchAvailableStands() async {
    final response = await _standService.list(isLibre: true);
    if (response.error != null) {
      throw Exception(response.error);
    }
    return response.data!;
  }

  Future<void> _inviteStand(int standId) async {
    final response = await _kermesseService.inviteStand(
      kermesseId: widget.kermesseId,
      standId: standId,
    );

    final message = response.error ?? 'Stand invité avec succès';
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

  @override
  Widget build(BuildContext context) {
    return ScreenList(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Ajouter un stand",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListFutureBuilder<StandListItem>(
              future: _fetchAvailableStands,
              builder: (context, item) {
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text(item.type),
                  trailing: ElevatedButton(
                    onPressed: () async {
                      await _inviteStand(item.id);
                    },
                    child: const Text('Ajouter'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
