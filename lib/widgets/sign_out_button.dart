import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:chall_mobile/router/auth_routes.dart';
import 'package:chall_mobile/providers/auth_provider.dart';
import 'package:chall_mobile/api/api_constants.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({Key? key}) : super(key: key);

  Future<void> _signOut(BuildContext context) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.remove(ApiConstants.tokenKey);

    Provider.of<AuthProvider>(context, listen: false)
        .setUser(-1, "", "", "", false);

    context.go(AuthRoutes.login);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Déconnecté avec succès")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _signOut(context),
      child: const Text("Se déconnecter"),
    );
  }
}
