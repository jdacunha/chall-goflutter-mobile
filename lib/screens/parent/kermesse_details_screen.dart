import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chall_mobile/api/api_response.dart';
import 'package:chall_mobile/data/kermesse_details_response.dart';
import 'package:chall_mobile/router/parent_routes.dart';
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

  Future<KermesseDetailsResponse> _fetchKermesseDetails() async {
    final response = await _kermesseService.details(
      kermesseId: widget.kermesseId,
    );
    if (response.error != null) {
      throw Exception(response.error);
    }
    return response.data!;
  }

  String _getKermesseStatus(String status) {
    switch (status) {
      case "STARTED":
        return "En cours";
      case "ENDED":
        return "Terminé";
      default:
        return status;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Détails de la Kermesse",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          DetailsFutureBuilder<KermesseDetailsResponse>(
            future: _fetchKermesseDetails,
            builder: (context, data) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("ID: ${data.id}"),
                  Text("Nom: ${data.name}"),
                  Text("Description: ${data.description}"),
                  Text("Statut: ${_getKermesseStatus(data.statut)}"),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.push(
                        ParentRoutes.kermesseDashboard,
                        extra: {"kermesseId": data.id},
                      );
                    },
                    child: const Text("Dashboard"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.push(
                        ParentRoutes.kermesseUserList,
                        extra: {"kermesseId": data.id},
                      );
                    },
                    child: const Text("Enfants"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.push(
                        ParentRoutes.kermesseStandList,
                        extra: {"kermesseId": data.id},
                      );
                    },
                    child: const Text("Stands"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.push(
                        ParentRoutes.kermesseInteractionList,
                        extra: {"kermesseId": data.id},
                      );
                    },
                    child: const Text("Interactions"),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
