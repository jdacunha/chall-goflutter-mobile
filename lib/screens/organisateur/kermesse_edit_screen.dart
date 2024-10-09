import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chall_mobile/data/kermesse_details_response.dart';
import 'package:chall_mobile/services/kermesse_service.dart';
import 'package:chall_mobile/widgets/details_future_builder.dart';
import 'package:chall_mobile/widgets/screen.dart';
import 'package:chall_mobile/widgets/text_input.dart';

class KermesseEditScreen extends StatefulWidget {
  final int kermesseId;

  const KermesseEditScreen({
    super.key,
    required this.kermesseId,
  });

  @override
  State<KermesseEditScreen> createState() => _KermesseEditScreenState();
}

class _KermesseEditScreenState extends State<KermesseEditScreen> {
  final KermesseService _kermesseService = KermesseService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool _isLoading = false;

  Future<KermesseDetailsResponse> _fetchKermesseDetails() async {
    final response = await _kermesseService.details(
      kermesseId: widget.kermesseId,
    );
    if (response.error != null) {
      throw Exception(response.error);
    }
    return response.data!;
  }

  Future<void> _submit() async {
    if (_nameController.text.isEmpty || _descriptionController.text.isEmpty) {
      _showSnackBar('Veuillez remplir tous les champs');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final response = await _kermesseService.edit(
      id: widget.kermesseId,
      name: _nameController.text.trim(),
      description: _descriptionController.text.trim(),
    );

    setState(() {
      _isLoading = false;
    });

    if (response.error != null) {
      _showSnackBar(response.error!);
    } else {
      _showSnackBar('Kermesse modifiée avec succès');
      context.pop();
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Modifier la Kermesse",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          DetailsFutureBuilder<KermesseDetailsResponse>(
            future: _fetchKermesseDetails,
            builder: (context, data) {
              _nameController.text = data.name;
              _descriptionController.text = data.description;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextInput(
                    hintText: "Nom",
                    controller: _nameController,
                  ),
                  const SizedBox(height: 16),
                  TextInput(
                    hintText: "Description",
                    controller: _descriptionController,
                  ),
                  const SizedBox(height: 24),
                  _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
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
    super.dispose();
  }
}
