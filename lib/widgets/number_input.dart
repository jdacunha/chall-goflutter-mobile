import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberInput extends StatelessWidget {
  final String hintText;
  final String? defaultValue;
  final TextEditingController controller;

  const NumberInput({
    super.key,
    this.hintText = '',
    this.defaultValue,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    if (defaultValue != null && controller.text.isEmpty) {
      controller.text = defaultValue!;
    }

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
    );
  }
}
