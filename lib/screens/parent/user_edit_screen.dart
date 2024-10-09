import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chall_mobile/api/api_constants.dart';
import 'package:chall_mobile/api/api_response.dart';
import 'package:chall_mobile/providers/auth_provider.dart';
import 'package:chall_mobile/router/auth_routes.dart';
import 'package:chall_mobile/services/user_service.dart';
import 'package:chall_mobile/widgets/password_input.dart';
import 'package:chall_mobile/widgets/screen.dart';

class UserEditScreen extends StatefulWidget {
  final int userId;

  const UserEditScreen({
    super.key,
    required this.userId,
  });

  @override
  State<UserEditScreen> createState() => _UserEditScreenState();
}

class _UserEditScreenState extends State<UserEditScreen> {
  final UserService _userService = UserService();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  Future<void> _submit() async {
    if (_passwordController.text.isEmpty || _newPasswordController.text.isEmpty) {
      _showSnackBar('Veuillez remplir tous les champs.', isError: true);
      return;
    }

    ApiResponse<Null> response = await _userService.edit(
      userId: widget.userId,
      password: _passwordController.text,
      newPassword: _newPasswordController.text,
    );

    if (response.error != null) {
      _showSnackBar(response.error!, isError: true);
    } else {
      await _handleSignOut();
      _showSnackBar('Mot de passe modifié avec succès.');
      context.go(AuthRoutes.login);
    }
  }

  Future<void> _handleSignOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(ApiConstants.tokenKey);
    Provider.of<AuthProvider>(context, listen: false).setUser(-1, "", "", "", false);
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
            "Modifier le mot de passe",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          PasswordInput(
            hintText: "Ancien mot de passe",
            controller: _passwordController,
          ),
          const SizedBox(height: 16),
          PasswordInput(
            hintText: "Nouveau mot de passe",
            controller: _newPasswordController,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _submit,
            child: const Text('Enregistrer'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }
}
