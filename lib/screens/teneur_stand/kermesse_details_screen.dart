import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chall_mobile/api/api_response.dart';
import 'package:chall_mobile/data/kermesse_details_response.dart';
import 'package:chall_mobile/router/teneur_stand_routes.dart';
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
    final response = await _kermesseService.details(kermesseId: widget.kermesseId);
    if (response.error != null) {
      _showErrorSnackBar(response.error!);
      throw Exception(response.error);
    }
    return response.data!;
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red[400],
      ),
    );
  }

  String _translateStatus(String status) {
    switch (status) {
      case 'STARTED':
        return 'En cours';
      case 'ENDED':
        return 'Terminée';
      default:
        return status;
    }
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

  Widget _buildNavigationButton(String label, String route, int kermesseId) {
    return ElevatedButton(
      onPressed: () {
        context.push(route, extra: {"kermesseId": kermesseId});
      },
      child: Text(label),
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
                  _buildKermesseDetail("Statut", _translateStatus(data.statut)),
                  const SizedBox(height: 16),
                  _buildNavigationButton("Dashboard", TeneurStandRoutes.kermesseDashboard, data.id),
                  _buildNavigationButton("Interactions", TeneurStandRoutes.kermesseInteractionList, data.id),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
