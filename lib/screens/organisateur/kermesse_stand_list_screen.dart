import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chall_mobile/data/stand_list_response.dart';
import 'package:chall_mobile/data/kermesse_details_response.dart';
import 'package:chall_mobile/router/organisateur_routes.dart';
import 'package:chall_mobile/services/stand_service.dart';
import 'package:chall_mobile/services/kermesse_service.dart';
import 'package:chall_mobile/widgets/list_future_builder.dart';
import 'package:chall_mobile/widgets/screen_list.dart';

class KermesseStandListScreen extends StatefulWidget {
  final int kermesseId;

  const KermesseStandListScreen({
    super.key,
    required this.kermesseId,
  });

  @override
  State<KermesseStandListScreen> createState() =>
      _KermesseStandListScreenState();
}

class _KermesseStandListScreenState extends State<KermesseStandListScreen> {
  final StandService _standService = StandService();
  final KermesseService _kermesseService = KermesseService();
  String _kermesseStatus = '';

  Future<List<StandListItem>> _fetchStands() async {
    final response = await _standService.list(kermesseId: widget.kermesseId);
    if (response.error != null) {
      throw Exception(response.error);
    }
    return response.data!;
  }

  Future<void> _fetchKermesseStatus() async {
    final response = await _kermesseService.details(kermesseId: widget.kermesseId);
    if (response.error != null) {
      throw Exception(response.error);
    }
    setState(() {
      _kermesseStatus = response.data!.statut;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchKermesseStatus();
  }

  void _inviteStand() {
    context.push(
      OrganisateurRoutes.kermesseStandInvite,
      extra: {'kermesseId': widget.kermesseId},
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenList(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Liste des Stands",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _kermesseStatus == 'ENDED' ? null : _inviteStand,
            child: Text(
              'Ajouter un Stand',
              style: TextStyle(
                color: _kermesseStatus == 'ENDED' ? Colors.grey : Colors.deepPurple,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListFutureBuilder<StandListItem>(
              future: _fetchStands,
              builder: (context, item) {
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text(item.type),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
