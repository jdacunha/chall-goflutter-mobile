import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chall_mobile/api/api_response.dart';
import 'package:chall_mobile/data/tombola_list_response.dart';
import 'package:chall_mobile/router/enfant_routes.dart';
import 'package:chall_mobile/services/tombola_service.dart';
import 'package:chall_mobile/widgets/list_future_builder.dart';
import 'package:chall_mobile/widgets/screen_list.dart';

class KermesseTombolaListScreen extends StatefulWidget {
  final int kermesseId;

  const KermesseTombolaListScreen({
    super.key,
    required this.kermesseId,
  });

  @override
  State<KermesseTombolaListScreen> createState() =>
      _KermesseTombolaListScreenState();
}

class _KermesseTombolaListScreenState extends State<KermesseTombolaListScreen> {
  final TombolaService _tombolaService = TombolaService();

  Future<List<TombolaListItem>> _getAll() async {
    ApiResponse<List<TombolaListItem>> response = await _tombolaService.list(
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
            "Tombola",
          ),
          Expanded(
            child: ListFutureBuilder<TombolaListItem>(
              future: _getAll,
              builder: (context, item) {
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text(item.lot),
                  onTap: () {
                    context.push(
                      EnfantRoutes.kermesseTombolaDetails,
                      extra: {
                        "tombolaId": item.id,
                        "kermesseId": widget.kermesseId,
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
