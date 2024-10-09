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
      _KermesseInteractionDetailsScreenState();
}

class _KermesseInteractionDetailsScreenState
    extends State<KermesseStandDetailsScreen> {
  final TextEditingController _quantityController = TextEditingController();

  final StandService _standService = StandService();
  final InteractionService _interactionService = InteractionService();

  Future<StandDetailsResponse> _get() async {
    ApiResponse<StandDetailsResponse> response = await _standService.details(
      standId: widget.standId,
    );
    if (response.error != null) {
      throw Exception(response.error);
    }
    return response.data!;
  }

  Future<void> _participate() async {
    ApiResponse<Null> response = await _interactionService.create(
      kermesseId: widget.kermesseId,
      standId: widget.standId,
      quantity: int.parse(_quantityController.text),
    );
    if (response.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.error!),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Participation réussie'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Détails du stand",
          ),
          DetailsFutureBuilder<StandDetailsResponse>(
            future: _get,
            builder: (context, data) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.name),
                  Text(data.description),
                  Text(data.type),
                  Text(data.price.toString()),
                  Text(data.stock.toString()),
                  data.type == "ACTIVITE"
                      ? SizedBox(
                          width: 0,
                          height: 0,
                          child: NumberInput(
                            defaultValue: "1",
                            controller: _quantityController,
                            hintText: "Quantity",
                          ),
                        )
                      : NumberInput(
                          defaultValue: "1",
                          controller: _quantityController,
                          hintText: "Quantity",
                        ),
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
    );
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }
}
