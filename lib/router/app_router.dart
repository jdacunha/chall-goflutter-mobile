import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:chall_mobile/providers/auth_user.dart';
import 'package:chall_mobile/router/enfant_routes.dart';
import 'package:chall_mobile/router/organisateur_routes.dart';
import 'package:chall_mobile/router/parent_routes.dart';
import 'package:chall_mobile/router/teneur_stand_routes.dart';
import 'package:chall_mobile/providers/auth_provider.dart';
import 'package:chall_mobile/router/auth_routes.dart';

class AppRouter {
  GoRouter goRouter(BuildContext context) {
    return GoRouter(
      initialLocation: AuthRoutes.login,
      refreshListenable: Provider.of<AuthProvider>(context, listen: false),
      redirect: (BuildContext context, GoRouterState state) {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        final AuthUser user = authProvider.user;
        final bool isLogged = authProvider.isLogged;

        if (!isLogged && !state.fullPath!.startsWith("/auth")) {
          return AuthRoutes.login;
        }

        if (isLogged && state.fullPath!.startsWith("/auth")) {
          return _redirectToRoleHome(user);
        }

        if (isLogged && user.role == "TENEUR_STAND") {
          if (!user.hasStand) {
            return TeneurStandRoutes.standCreate;
          }
          if (user.hasStand && state.fullPath!.startsWith("/stand-holder/stand-create")) {
            return TeneurStandRoutes.standDetails;
          }
        }

        return null;
      },
      routes: [
        ...AuthRouter.routes,
        OrganisateurRouter.routes,
        TeneurStandRouter.routes,
        ParentRouter.routes,
        EnfantRouter.routes,
      ],
    );
  }

  String _redirectToRoleHome(AuthUser user) {
    switch (user.role) {
      case "ORGANISATEUR":
        return OrganisateurRoutes.profile;
      case "TENEUR_STAND":
        return TeneurStandRoutes.userDetails;
      case "PARENT":
        return ParentRoutes.userDetails;
      case "ENFANT":
        return EnfantRoutes.userDetails;
      default:
        return AuthRoutes.login;
    }
  }
}
