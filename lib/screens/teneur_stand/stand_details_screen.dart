import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chall_mobile/api/api_response.dart';
import 'package:chall_mobile/data/stand_details_response.dart';
import 'package:chall_mobile/router/teneur_stand_routes.dart';
import 'package:chall_mobile/services/stand_service.dart';
import 'package:chall_mobile/widgets/details_future_builder.dart';
import 'package:chall_mobile/widgets/screen.dart';

class StandDetailsScreen extends StatefulWidget {
  const StandDetailsScreen({
    super.key,
  });

  @override
  State<StandDetailsScreen> createState() => _StandDetailsScreenState();
}

class _StandDetailsScreenState extends State<StandDetailsScreen> {
  final StandService _standService = StandService();

  Future<StandDetailsResponse> _fetchStandDetails() async {
    final response = await _standService.current();
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

  Widget _buildStandDetail(String label, String value) {
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

  @override
  Widget build(BuildContext context) {
    return Screen(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Détails du stand",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          DetailsFutureBuilder<StandDetailsResponse>(
            future: _fetchStandDetails,
            builder: (context, data) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStandDetail("Nom", data.name),
                  _buildStandDetail("Description", data.description),
                  _buildStandDetail("Type", data.type),
                  _buildStandDetail("Prix", data.price.toString()),
                  if (data.type == "VENTE")
                    _buildStandDetail("Stock", data.stock.toString()),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.push(
                        TeneurStandRoutes.standEdit,
                      );
                    },
                    child: const Text('Modifier'),
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
