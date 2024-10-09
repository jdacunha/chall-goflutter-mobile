import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chall_mobile/api/api_response.dart';
import 'package:chall_mobile/data/tombola_list_response.dart';
import 'package:chall_mobile/router/organisateur_routes.dart';
import 'package:chall_mobile/services/tombola_service.dart';
import 'package:chall_mobile/widgets/list_future_builder.dart';
import 'package:chall_mobile/widgets/screen_list.dart';

class KermesseTombolaListScreen extends StatefulWidget {
  final int kermesseId;

  const KermesseTombolaListScreen({
    Key? key,
    required this.kermesseId,
  }) : super(key: key);

  @override
  State<KermesseTombolaListScreen> createState() =>
      _KermesseTombolaListScreenState();
}

class _KermesseTombolaListScreenState extends State<KermesseTombolaListScreen> {
  final TombolaService _tombolaService = TombolaService();

  Future<List<TombolaListItem>> _fetchTombolas() async {
    final response = await _tombolaService.list(kermesseId: widget.kermesseId);
    if (response.error != null) {
      throw Exception(response.error);
    }
    return response.data!;
  }

  void _navigateToCreateTombola() {
    context.push(
      OrganisateurRoutes.kermesseTombolaCreate,
      extra: {"kermesseId": widget.kermesseId},
    );
  }

  void _navigateToTombolaDetails(TombolaListItem item) {
    context.push(
      OrganisateurRoutes.kermesseTombolaDetails,
      extra: {
        "tombolaId": item.id,
        "kermesseId": widget.kermesseId,
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
            "Tombola",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _navigateToCreateTombola,
            child: const Text('Créer une tombola'),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListFutureBuilder<TombolaListItem>(
              future: _fetchTombolas,
              builder: (context, item) {
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text(item.lot),
                  onTap: () => _navigateToTombolaDetails(item),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
