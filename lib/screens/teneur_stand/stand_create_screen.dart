import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chall_mobile/api/api_response.dart';
import 'package:chall_mobile/providers/auth_provider.dart';
import 'package:chall_mobile/router/teneur_stand_routes.dart';
import 'package:chall_mobile/services/stand_service.dart';
import 'package:chall_mobile/widgets/number_input.dart';
import 'package:chall_mobile/widgets/screen.dart';
import 'package:chall_mobile/widgets/stand_type_select.dart';
import 'package:chall_mobile/widgets/text_input.dart';
import 'package:provider/provider.dart';

class StandCreateScreen extends StatefulWidget {
  const StandCreateScreen({super.key});

  @override
  State<StandCreateScreen> createState() => _StandCreateScreenState();
}

class _StandCreateScreenState extends State<StandCreateScreen> {
  final StandService _standService = StandService();

  String _selectedType = "ACTIVITE";
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();

  Future<void> _submit() async {
    if (_validateInputs()) {
      final response = await _standService.create(
        type: _selectedType,
        name: _nameController.text,
        description: _descriptionController.text,
        price: int.parse(_priceController.text),
        stock: _selectedType == "VENTE" ? int.parse(_stockController.text) : 0,
      );

      if (response.error != null) {
        _showSnackBar(response.error!, isError: true);
      } else {
        _showSnackBar('Stand créé avec succès');
        Provider.of<AuthProvider>(context, listen: false).setHasStand(true);
        context.go(TeneurStandRoutes.kermesseList);
      }
    }
  }

  bool _validateInputs() {
    if (_nameController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _priceController.text.isEmpty ||
        (_selectedType == "VENTE" && _stockController.text.isEmpty)) {
      _showSnackBar('Veuillez remplir tous les champs', isError: true);
      return false;
    }
    return true;
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
            "Créer un stand",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          StandTypeSelect(
            defaultValue: _selectedType,
            onChange: (value) {
              setState(() {
                _selectedType = value;
              });
            },
          ),
          const SizedBox(height: 8),
          TextInput(
            hintText: "Nom",
            controller: _nameController,
          ),
          const SizedBox(height: 8),
          TextInput(
            hintText: "Description",
            controller: _descriptionController,
          ),
          const SizedBox(height: 8),
          NumberInput(
            hintText: "Prix",
            controller: _priceController,
          ),
          const SizedBox(height: 8),
          if (_selectedType == "VENTE")
            NumberInput(
              hintText: "Stock",
              controller: _stockController,
            ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _submit,
            child: const Text('Créer'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    super.dispose();
  }
}
