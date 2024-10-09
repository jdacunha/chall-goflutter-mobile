import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chall_mobile/api/api_response.dart';
import 'package:chall_mobile/data/stand_details_response.dart';
import 'package:chall_mobile/services/stand_service.dart';
import 'package:chall_mobile/widgets/details_future_builder.dart';
import 'package:chall_mobile/widgets/number_input.dart';
import 'package:chall_mobile/widgets/screen.dart';
import 'package:chall_mobile/widgets/text_input.dart';

class StandEditScreen extends StatefulWidget {
  const StandEditScreen({
    super.key,
  });

  @override
  State<StandEditScreen> createState() => _StandEditScreenState();
}

class _StandEditScreenState extends State<StandEditScreen> {
  final StandService _standService = StandService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();

  Future<StandDetailsResponse> _fetchStandDetails() async {
    final response = await _standService.current();
    if (response.error != null) {
      _showSnackBar(response.error!, isError: true);
      throw Exception(response.error);
    }
    return response.data!;
  }

  Future<void> _submit() async {
    final response = await _standService.edit(
      name: _nameController.text,
      description: _descriptionController.text,
      price: int.parse(_priceController.text),
      stock: _stockController.text.isNotEmpty
          ? int.parse(_stockController.text)
          : 0,
    );
    if (response.error != null) {
      _showSnackBar(response.error!, isError: true);
    } else {
      _showSnackBar('Stand modifié avec succès');
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
            "Modifier le stand",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          DetailsFutureBuilder<StandDetailsResponse>(
            future: _fetchStandDetails,
            builder: (context, data) {
              _nameController.text = data.name;
              _descriptionController.text = data.description;
              _priceController.text = data.price.toString();
              if (data.type == "VENTE") {
                _stockController.text = data.stock.toString();
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  if (data.type == "VENTE")
                    NumberInput(
                      hintText: "Stock",
                      controller: _stockController,
                    ),
                  const SizedBox(height: 16),
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

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    super.dispose();
  }
}
