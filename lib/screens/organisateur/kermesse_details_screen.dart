import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chall_mobile/data/kermesse_details_response.dart';
import 'package:chall_mobile/router/organisateur_routes.dart';
import 'package:chall_mobile/services/kermesse_service.dart';
import 'package:chall_mobile/widgets/details_future_builder.dart';
import 'package:chall_mobile/widgets/screen.dart';
import 'package:go_router/go_router.dart';

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

  Future<void> _endKermesse() async {
    final response = await _kermesseService.end(id: widget.kermesseId);
    final message = response.error ?? 'Kermesse terminée avec succès';
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
    return Screen(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Détails de la kermesse",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          DetailsFutureBuilder<KermesseDetailsResponse>(
            future: _fetchKermesseDetails,
            builder: (context, data) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildKermesseDetail("Nom", data.name),
                  _buildKermesseDetail("Description", data.description),
                  _buildKermesseDetail("Statut", data.statut),
                  const SizedBox(height: 16),
                  if (data.statut == "STARTED") _buildActionButtons(data),
                  _buildNavigationButton(
                    "Dashboard",
                    OrganisateurRoutes.kermesseDashboard,
                    data.id,
                  ),
                  _buildNavigationButton(
                    "Participants",
                    OrganisateurRoutes.kermesseUserList,
                    data.id,
                  ),
                  _buildNavigationButton(
                    "Stands",
                    OrganisateurRoutes.kermesseStandList,
                    data.id,
                  ),
                  _buildNavigationButton(
                    "Tombola",
                    OrganisateurRoutes.kermesseTombolaList,
                    data.id,
                  ),
                  _buildNavigationButton(
                    "Interactions",
                    OrganisateurRoutes.kermesseInteractionList,
                    data.id,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildKermesseDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildActionButtons(KermesseDetailsResponse data) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            context.push(
              OrganisateurRoutes.kermesseEdit,
              extra: {"kermesseId": data.id},
            );
          },
          child: const Text("Modifier"),
        ),
        ElevatedButton(
          onPressed: _endKermesse,
          child: const Text("Terminer la kermesse"),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildNavigationButton(String label, String route, int kermesseId) {
    return ElevatedButton(
      onPressed: () {
        context.push(route, extra: {"kermesseId": kermesseId});
      },
      child: Text(label),
    );
  }
}
