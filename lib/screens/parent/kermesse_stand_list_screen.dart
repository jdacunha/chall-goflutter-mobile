import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chall_mobile/api/api_response.dart';
import 'package:chall_mobile/data/stand_list_response.dart';
import 'package:chall_mobile/router/parent_routes.dart';
import 'package:chall_mobile/services/stand_service.dart';
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

  Future<List<StandListItem>> _getAll() async {
    ApiResponse<List<StandListItem>> response = await _standService.list(
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
            "Liste des stands",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListFutureBuilder<StandListItem>(
              future: _getAll,
              builder: (context, item) {
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text(item.type),
                  onTap: () {
                    context.push(
                      ParentRoutes.kermesseStandDetails,
                      extra: {
                        "kermesseId": widget.kermesseId,
                        "standId": item.id,
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
