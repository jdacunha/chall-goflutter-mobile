import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chall_mobile/api/api_response.dart';
import 'package:chall_mobile/data/kermesse_list_response.dart';
import 'package:chall_mobile/router/organisateur_routes.dart';
import 'package:chall_mobile/services/kermesse_service.dart';
import 'package:chall_mobile/widgets/list_future_builder.dart';
import 'package:chall_mobile/widgets/screen_list.dart';

class KermesseListScreen extends StatefulWidget {
  const KermesseListScreen({super.key});

  @override
  State<KermesseListScreen> createState() => _KermesseListScreenState();
}

class _KermesseListScreenState extends State<KermesseListScreen> {
  final KermesseService _kermesseService = KermesseService();

  Future<List<KermesseListItem>> _fetchKermesseList() async {
    final response = await _kermesseService.list();
    if (response.error != null) {
      throw Exception(response.error);
    }
    return response.data ?? [];
  }

  void _navigateToCreateKermesse() {
    context.push(OrganisateurRoutes.kermesseCreate);
  }

  void _navigateToKermesseDetails(int kermesseId) {
    context.push(
      OrganisateurRoutes.kermesseDetails,
      extra: {"kermesseId": kermesseId},
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenList(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Vos Kermesses",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _navigateToCreateKermesse,
            child: const Text('Créer une Kermesse'),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListFutureBuilder<KermesseListItem>(
              future: _fetchKermesseList,
              builder: (context, item) {
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text(item.description),
                  onTap: () => _navigateToKermesseDetails(item.id),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
