import 'package:chall_mobile/router/enfant_routes.dart';
import 'package:chall_mobile/router/parent_routes.dart';
import 'package:chall_mobile/router/teneur_stand_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:chall_mobile/api/api_response.dart';
import 'package:chall_mobile/providers/auth_provider.dart';
import 'package:chall_mobile/router/organisateur_routes.dart';
import 'package:chall_mobile/services/auth_service.dart';
import 'package:chall_mobile/data/login_response.dart';
import 'package:chall_mobile/router/auth_routes.dart';
import 'package:chall_mobile/api/api_constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  Future<void> _submit() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      _showErrorSnackBar('Veuillez remplir les deux champs');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final response = await _authService.login(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    setState(() {
      _isLoading = false;
    });

    if (response.error != null) {
      _showErrorSnackBar(response.error!);
    } else if (response.data != null) {
      await _saveTokenAndUserData(response.data!);
      _showSuccessSnackBar('Connexion réussie');
    }
  }

  Future<void> _saveTokenAndUserData(LoginResponse data) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(ApiConstants.tokenKey, data.token);

    Provider.of<AuthProvider>(context, listen: false).setUser(
      data.id,
      data.name,
      data.email,
      data.role,
      data.hasStand,
    );

    switch (data.role) {
      case "ORGANISATEUR":
        context.go(OrganisateurRoutes.profile);
        break;
      case "TENEUR_STAND":
        context.go(TeneurStandRoutes.userDetails);
        break;
      case "PARENT":
        context.go(ParentRoutes.userDetails);
        break;
      case "ENFANT":
        context.go(EnfantRoutes.userDetails);
        break;
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _showSuccessSnackBar(String message) {
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
              const Text('Se connecter', style: TextStyle(fontSize: 24)),
              const SizedBox(height: 16),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Mot de passe',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: _submit,
                child: const Text('Se connecter'),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  context.push(AuthRoutes.register);
                },
                child: const Text('Créer un compte'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
