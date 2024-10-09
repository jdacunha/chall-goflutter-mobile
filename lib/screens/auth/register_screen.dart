import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chall_mobile/services/auth_service.dart';
import 'package:chall_mobile/api/api_response.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String _selectedRole = "ORGANISATEUR";
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  Future<void> _submit() async {
    if (_isAnyFieldEmpty()) {
      _showSnackBar('Veillez remplir tous les champs');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final response = await _authService.register(
      role: _selectedRole.trim(),
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    setState(() {
      _isLoading = false;
    });

    if (response.error != null) {
      _showSnackBar(response.error!);
    } else {
      context.pop();
      _showSnackBar('Inscription réussie');
    }
  }

  bool _isAnyFieldEmpty() {
    return _selectedRole.isEmpty ||
        _nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty;
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Inscription',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 16),
              _buildRoleSelect(),
              const SizedBox(height: 16),
              _buildTextField(_nameController, 'Nom'),
              const SizedBox(height: 16),
              _buildTextField(_emailController, 'Email'),
              const SizedBox(height: 16),
              _buildTextField(_passwordController, 'Mot de passe', obscureText: true),
              const SizedBox(height: 24),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: _submit,
                child: const Text('S\'inscrire'),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  context.pop();
                },
                child: const Text('Se connecter'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleSelect() {
    return DropdownButtonFormField<String>(
      value: _selectedRole,
      onChanged: (String? newValue) {
        setState(() {
          _selectedRole = newValue!;
        });
      },
      items: const [
        DropdownMenuItem(
          value: 'ORGANISATEUR',
          child: Text('Organisateur'),
        ),
        DropdownMenuItem(
          value: 'TENEUR_STAND',
          child: Text('Teneur de Stand'),
        ),
        DropdownMenuItem(
          value: 'PARENT',
          child: Text('Parent'),
        ),
      ],
      decoration: const InputDecoration(
        labelText: 'Rôle',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller,
      String hintText, {
        bool obscureText = false,
      }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: hintText,
        border: const OutlineInputBorder(),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
