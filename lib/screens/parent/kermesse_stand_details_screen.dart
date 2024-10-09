import 'package:flutter/material.dart';
import 'package:chall_mobile/api/api_response.dart';
import 'package:chall_mobile/data/stand_details_response.dart';
import 'package:chall_mobile/services/interaction_service.dart';
import 'package:chall_mobile/services/stand_service.dart';
import 'package:chall_mobile/widgets/details_future_builder.dart';
import 'package:chall_mobile/widgets/number_input.dart';
import 'package:chall_mobile/widgets/screen.dart';

class KermesseStandDetailsScreen extends StatefulWidget {
  final int kermesseId;
  final int standId;

  const KermesseStandDetailsScreen({
    super.key,
    required this.kermesseId,
    required this.standId,
  });

  @override
  State<KermesseStandDetailsScreen> createState() =>
      _KermesseStandDetailsScreenState();
}

class _KermesseStandDetailsScreenState
    extends State<KermesseStandDetailsScreen> {
  final StandService _standService = StandService();
  final InteractionService _interactionService = InteractionService();
  final TextEditingController _quantityController = TextEditingController(text: "1");

  Future<StandDetailsResponse> _fetchStandDetails() async {
    final response = await _standService.details(standId: widget.standId);
    if (response.error != null) {
      throw Exception('Erreur lors de la récupération des détails du stand: ${response.error}');
    }
    return response.data!;
  }

  Future<void> _participate() async {
    final response = await _interactionService.create(
      kermesseId: widget.kermesseId,
      standId: widget.standId,
      quantity: int.parse(_quantityController.text),
    );
    final message = response.error ?? 'Participation réussie';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                      Text("Nom: ${data.name}"),
                      Text("Description: ${data.description}"),
                      Text("Type: ${data.type}"),
                      Text("Prix: ${data.price} €"),
                      if (data.type == "VENTE")
                        Text("Stock: ${data.stock}"),
                      const SizedBox(height: 16),
                      if (data.type != "ACTIVITE")
                        NumberInput(
                          controller: _quantityController,
                          hintText: "Quantité",
                          defaultValue: "1",
                        ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _participate,
                        child: const Text("Participer"),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }


  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }
}
