import 'package:flutter/material.dart';

class PasswordInput extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;

  const PasswordInput({
    super.key,
    this.hintText = '',
    required this.controller,
  });

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: _toggleVisibility,
        ),
      ),
      obscureText: _obscureText,
      keyboardType: TextInputType.visiblePassword,
    );
  }
}
