import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chall_mobile/api/api_response.dart';
import 'package:chall_mobile/data/kermesse_details_response.dart';
import 'package:chall_mobile/router/enfant_routes.dart';
import 'package:chall_mobile/services/kermesse_service.dart';
import 'package:chall_mobile/widgets/details_future_builder.dart';
import 'package:chall_mobile/widgets/screen.dart';

class KermesseDetailsScreen extends StatefulWidget {
  final int kermesseId;

  const KermesseDetailsScreen({
    super.key,
    required this.kermesseId,
  });

  @override
  State<KermesseDetailsScreen> createState() => _KermesseDetailsScreenState();
}

class _KermesseDetailsScreenState extends State<KermesseDetailsScreen> {
  final KermesseService _kermesseService = KermesseService();

  Future<KermesseDetailsResponse> _get() async {
    ApiResponse<KermesseDetailsResponse> response =
        await _kermesseService.details(
      kermesseId: widget.kermesseId,
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
            "Détails de la kermesse",
          ),
          DetailsFutureBuilder<KermesseDetailsResponse>(
            future: _get,
            builder: (context, data) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.id.toString()),
                  Text(data.name),
                  Text(data.description),
                  Text(data.statut),
                  ElevatedButton(
                    onPressed: () {
                      context.push(
                        EnfantRoutes.kermesseStandList,
                        extra: {
                          "kermesseId": data.id,
                        },
                      );
                    },
                    child: const Text("Stands"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.push(
                        EnfantRoutes.kermesseTombolaList,
                        extra: {
                          "kermesseId": data.id,
                        },
                      );
                    },
                    child: const Text("Tombolas"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.push(
                        EnfantRoutes.kermesseInteractionList,
                        extra: {
                          "kermesseId": data.id,
                        },
                      );
                    },
                    child: const Text("Interactions"),
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
