import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chall_mobile/services/kermesse_service.dart';
import 'package:chall_mobile/widgets/screen.dart';

class KermesseCreateScreen extends StatefulWidget {
  const KermesseCreateScreen({super.key});

  @override
  State<KermesseCreateScreen> createState() => _KermesseCreateScreenState();
}

class _KermesseCreateScreenState extends State<KermesseCreateScreen> {
  final KermesseService _kermesseService = KermesseService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool _isLoading = false;

  Future<void> _submit() async {
    if (_nameController.text.isEmpty || _descriptionController.text.isEmpty) {
      _showSnackBar('Veuillez remplir tous les champs');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final response = await _kermesseService.create(
      name: _nameController.text.trim(),
      description: _descriptionController.text.trim(),
    );

    setState(() {
      _isLoading = false;
    });

    if (response.error != null) {
      _showSnackBar(response.error!);
    } else {
      _showSnackBar('Kermesse créée avec succès');
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
            "Créer une Kermesse",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildTextField(_nameController, 'Nom'),
          const SizedBox(height: 16),
          _buildTextField(_descriptionController, 'Description'),
          const SizedBox(height: 24),
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : ElevatedButton(
            onPressed: _submit,
            child: const Text('Enregistrer'),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText) {
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
    _descriptionController.dispose();
    super.dispose();
  }
}
