import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chall_mobile/api/api_response.dart';
import 'package:chall_mobile/services/tombola_service.dart';
import 'package:chall_mobile/widgets/number_input.dart';
import 'package:chall_mobile/widgets/screen.dart';

class KermesseTombolaCreateScreen extends StatefulWidget {
  final int kermesseId;

  const KermesseTombolaCreateScreen({
    super.key,
    required this.kermesseId,
  });

  @override
  State<KermesseTombolaCreateScreen> createState() =>
      _KermesseTombolaCreateScreenState();
}

class _KermesseTombolaCreateScreenState
    extends State<KermesseTombolaCreateScreen> {
  final TombolaService _tombolaService = TombolaService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _giftController = TextEditingController();

  Future<void> _submit() async {
    if (_validateInputs()) {
      final response = await _tombolaService.create(
        kermesseId: widget.kermesseId,
        name: _nameController.text.trim(),
        price: int.parse(_priceController.text.trim()),
        lot: _giftController.text.trim(),
      );

      final message = response.error ?? 'Tombola créée avec succès';
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
        backgroundColor: isError ? Colors.red : Colors.green,
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
            "Créer une tombola",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildTextField(controller: _nameController, hintText: 'Nom'),
          const SizedBox(height: 16),
          NumberInput(
            hintText: "Prix",
            controller: _priceController,
          ),
          const SizedBox(height: 16),
          _buildTextField(controller: _giftController, hintText: 'Lot'),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _submit,
            child: const Text('Créer'),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _giftController.dispose();
    super.dispose();
  }
}
