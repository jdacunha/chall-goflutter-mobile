import 'package:go_router/go_router.dart';
import 'organisateur_bottom_navigation.dart';
import 'package:chall_mobile/screens/organisateur/accueil_screen.dart';
import 'package:chall_mobile/screens/organisateur/profile_screen.dart';


class OrganisateurRoutes {
  static const String accueil = '/organisateur/accueil';
  static const String profile = '/organisateur/profile';
}


class OrganisateurRouter {
  static StatefulShellRoute routes = StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) {
      return OrganisateurBottomNavigation(navigationShell: navigationShell);
    },
    branches: [
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: OrganisateurRoutes.accueil,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: AccueilScreen(),
            ),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: OrganisateurRoutes.profile,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ProfileScreen(),
            ),
          ),
        ],
      ),
    ],
  );
}
