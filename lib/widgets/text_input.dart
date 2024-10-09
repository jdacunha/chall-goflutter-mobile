import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String hintText;
  final String? defaultValue;
  final TextEditingController controller;

  const TextInput({
    super.key,
    this.hintText = '',
    this.defaultValue,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    // Si le texte du contrôleur est vide, assigner la valeur par défaut
    if (defaultValue != null && controller.text.isEmpty) {
      controller.text = defaultValue!;
    }

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
