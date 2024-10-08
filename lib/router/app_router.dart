import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:chall_mobile/providers/auth_user.dart';
import 'package:chall_mobile/providers/auth_provider.dart';
import 'auth_routes.dart';
import 'organisateur_routes.dart';

class AppRouter {
  GoRouter goRouter(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return GoRouter(
      initialLocation: AuthRoutes.login,
      refreshListenable: authProvider,
      redirect: (BuildContext context, GoRouterState state) {
        final AuthUser user = authProvider.user;
        final bool isLogged = authProvider.isLogged;
        final String fullPath = state.fullPath ?? '';

        // Redirection if user is not logged in and is trying to access a non-auth route
        if (!isLogged && !fullPath.startsWith("/auth")) {
          return AuthRoutes.login;
        }

        // Redirection if user is logged in but is in the /auth section
        if (isLogged && fullPath.startsWith("/auth")) {
          return _getDashboardRouteForRole(user.role);
        }

        return null;
      },
      routes: [
        ...AuthRouter.routes,
        OrganisateurRouter.routes,
        
      ],
    );
  }

  // Helper method to get the correct dashboard route based on the user's role
  String _getDashboardRouteForRole(String role) {
    switch (role) {
      case "ORGANISATEUR":
        return OrganisateurRoutes.accueil;
      case "TENEUR_STAND":
        return OrganisateurRoutes.accueil;
      case "PARENT":
        return OrganisateurRoutes.accueil;
      case "ENFANT":
        return OrganisateurRoutes.accueil;
      default:
        return AuthRoutes.login;
    }
  }
}
