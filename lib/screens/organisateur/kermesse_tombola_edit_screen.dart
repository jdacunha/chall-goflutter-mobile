import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chall_mobile/api/api_response.dart';
import 'package:chall_mobile/data/tombola_details_response.dart';
import 'package:chall_mobile/services/tombola_service.dart';
import 'package:chall_mobile/widgets/details_future_builder.dart';
import 'package:chall_mobile/widgets/number_input.dart';
import 'package:chall_mobile/widgets/screen.dart';
import 'package:chall_mobile/widgets/text_input.dart';

class KermesseTombolaEditScreen extends StatefulWidget {
  final int kermesseId;
  final int tombolaId;

  const KermesseTombolaEditScreen({
    super.key,
    required this.tombolaId,
    required this.kermesseId,
  });

  @override
  State<KermesseTombolaEditScreen> createState() =>
      _KermesseTombolaEditScreenState();
}

class _KermesseTombolaEditScreenState extends State<KermesseTombolaEditScreen> {
  final TombolaService _tombolaService = TombolaService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _giftController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _giftController.dispose();
    super.dispose();
  }

  Future<TombolaDetailsResponse> _fetchTombolaDetails() async {
    final response = await _tombolaService.details(
      tombolaId: widget.tombolaId,
    );
    if (response.error != null) {
      throw Exception(response.error);
    }
    return response.data!;
  }

  Future<void> _submit() async {
    if (_validateInputs()) {
      final response = await _tombolaService.edit(
        id: widget.tombolaId,
        name: _nameController.text.trim(),
        price: int.parse(_priceController.text.trim()),
        lot: _giftController.text.trim(),
      );

      final message = response.error ?? 'Tombola modifiée avec succès';
      _showSnackBar(message, isError: response.error != null);

      if (response.error == null) {
        context.pop();
      }
    } else {
      _showSnackBar('Veuillez remplir tous les champs', isError: true);
    }
  }

  bool _validateInputs() {
    return _nameController.text.isNotEmpty &&
        _priceController.text.isNotEmpty &&
        _giftController.text.isNotEmpty;
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
            "Modifier la tombola",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          DetailsFutureBuilder<TombolaDetailsResponse>(
            future: _fetchTombolaDetails,
            builder: (context, data) {
              _nameController.text = data.name;
              _priceController.text = data.price.toString();
              _giftController.text = data.lot;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextInput(
                    hintText: "Nom",
                    controller: _nameController,
                  ),
                  const SizedBox(height: 16),
                  NumberInput(
                    hintText: "Prix",
                    controller: _priceController,
                  ),
                  const SizedBox(height: 16),
                  TextInput(
                    hintText: "Lot",
                    controller: _giftController,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _submit,
                    child: const Text('Enregistrer'),
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
