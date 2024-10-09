import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chall_mobile/api/api_response.dart';
import 'package:chall_mobile/data/kermesse_list_response.dart';
import 'package:chall_mobile/router/enfant_routes.dart';
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

  Future<List<KermesseListItem>> _getAll() async {
    ApiResponse<List<KermesseListItem>> response =
        await _kermesseService.list();
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
            "Liste de mes kermesses",
          ),
          Expanded(
            child: ListFutureBuilder<KermesseListItem>(
              future: _getAll,
              builder: (context, item) {
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text(item.description),
                  onTap: () {
                    context.push(
                      EnfantRoutes.kermesseDetails,
                      extra: {
                        "kermesseId": item.id,
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
