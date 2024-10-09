import 'package:go_router/go_router.dart';
import 'package:chall_mobile/providers/auth_provider.dart';
import 'package:chall_mobile/providers/auth_user.dart';

import 'package:chall_mobile/router/teneur_stand_bottom_navigation.dart';
import 'package:chall_mobile/screens/teneur_stand/accueil_screen.dart';
//import 'package:chall_mobile/screens/teneur_stand/kermesse_dashboard_screen.dart';
import 'package:chall_mobile/screens/teneur_stand/kermesse_details_screen.dart';
import 'package:chall_mobile/screens/teneur_stand/kermesse_interaction_details_screen.dart';
import 'package:chall_mobile/screens/teneur_stand/kermesse_interaction_list_screen.dart';
import 'package:chall_mobile/screens/teneur_stand/kermesse_list_screen.dart';
import 'package:chall_mobile/screens/teneur_stand/stand_create_screen.dart';
import 'package:chall_mobile/screens/teneur_stand/stand_details_screen.dart';
import 'package:chall_mobile/screens/teneur_stand/stand_edit_screen.dart';
import 'package:chall_mobile/screens/teneur_stand/profile_screen.dart';
import 'package:chall_mobile/screens/teneur_stand/user_edit_screen.dart';
import 'package:provider/provider.dart';


class TeneurStandRoutes {
  static const String accueil = '/teneur-stand/accueil';
  static const String userDetails = '/teneur-stand/user-details';
  static const String userEdit = '/teneur-stand/user-edit';
  static const String kermesseList = '/teneur-stand/kermesse-list';
  static const String kermesseDetails = '/teneur-stand/kermesse-details';
  static const String kermesseDashboard = '/teneur-stand/kermesse-dashboard';
  static const String kermesseInteractionList =
      '/teneur-stand/kermesse-interaction-list';
  static const String kermesseInteractionDetails =
      '/teneur-stand/kermesse-interaction-details';
  static const String standDetails = '/teneur-stand/stand-details';
  static const String standEdit = '/teneur-stand/stand-edit';
  static const String standCreate = '/teneur-stand/stand-create';
}


class TeneurStandRouter {
  static StatefulShellRoute routes = StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) {
      return TeneurStandBottomNavigation(navigationShell: navigationShell);
    },
    branches: [
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: TeneurStandRoutes.userDetails,
            pageBuilder: (context, state) {
              AuthUser user =
                  Provider.of<AuthProvider>(context, listen: false).user;
              return NoTransitionPage(
                child: ProfileScreen(
                  userId: user.id,
                ),
              );
            },
          ),
          GoRoute(
            path: TeneurStandRoutes.userEdit,
            pageBuilder: (context, state) {
              AuthUser user =
                  Provider.of<AuthProvider>(context, listen: false).user;
              return NoTransitionPage(
                child: UserEditScreen(
                  userId: user.id,
                ),
              );
            },
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: TeneurStandRoutes.kermesseList,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: KermesseListScreen(),
            ),
          ),
          GoRoute(
            path: TeneurStandRoutes.kermesseDetails,
            pageBuilder: (context, state) {
              final params =
              GoRouterState.of(context).extra as Map<String, int>;
              return NoTransitionPage(
                child: KermesseDetailsScreen(
                  kermesseId: params['kermesseId']!,
                ),
              );
            },
          ),
          GoRoute(
            path: TeneurStandRoutes.kermesseInteractionList,
            pageBuilder: (context, state) {
              final params =
              GoRouterState.of(context).extra as Map<String, int>;
              return NoTransitionPage(
                child: KermesseInteractionListScreen(
                  kermesseId: params['kermesseId']!,
                ),
              );
            },
          ),
          GoRoute(
            path: TeneurStandRoutes.kermesseInteractionDetails,
            pageBuilder: (context, state) {
              final params =
              GoRouterState.of(context).extra as Map<String, int>;
              return NoTransitionPage(
                child: KermesseInteractionDetailsScreen(
                  kermesseId: params['kermesseId']!,
                  interactionId: params['interactionId']!,
                ),
              );
            },
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: TeneurStandRoutes.standDetails,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: StandDetailsScreen(),
            ),
          ),
          GoRoute(
            path: TeneurStandRoutes.standEdit,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: StandEditScreen(),
            ),
          ),
          GoRoute(
            path: TeneurStandRoutes.standCreate,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: StandCreateScreen(),
            ),
          ),
        ],
      ),

    ],
  );
}
