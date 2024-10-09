import 'package:go_router/go_router.dart';
import 'package:chall_mobile/providers/auth_provider.dart';
import 'package:chall_mobile/providers/auth_user.dart';

import 'package:chall_mobile/router/enfant_bottom_navigation.dart';
import 'package:chall_mobile/screens/enfant/kermesse_details_screen.dart';
import 'package:chall_mobile/screens/enfant/kermesse_interaction_details_screen.dart';
import 'package:chall_mobile/screens/enfant/kermesse_interaction_list_screen.dart';
import 'package:chall_mobile/screens/enfant/kermesse_list_screen.dart';
import 'package:chall_mobile/screens/enfant/kermesse_stand_details_screen.dart';
import 'package:chall_mobile/screens/enfant/kermesse_stand_list_screen.dart';
import 'package:chall_mobile/screens/enfant/kermesse_tombola_details_screen.dart';
import 'package:chall_mobile/screens/enfant/kermesse_tombola_list_screen.dart';
import 'package:chall_mobile/screens/enfant/ticket_details_screen.dart';
import 'package:chall_mobile/screens/enfant/ticket_list_screen.dart';
import 'package:chall_mobile/screens/enfant/user_details_screen.dart';
import 'package:chall_mobile/screens/enfant/user_edit_screen.dart';
import 'package:provider/provider.dart';

import '../screens/parent/user_details_screen.dart';
import 'enfant_bottom_navigation.dart';

class EnfantRoutes {
  static const String userDetails = '/enfant/user-details';
  static const String userEdit = '/enfant/user-edit';
  static const String kermesseList = '/enfant/kermesse-list';
  static const String kermesseDetails = '/enfant/kermesse-details';
  static const String kermesseDashboard = '/enfant/kermesse-dashboard';
  static const String kermesseStandList = '/enfant/kermesse-stand-list';
  static const String kermesseStandDetails = '/enfant/kermesse-stand-details';
  static const String kermesseInteractionList =
      '/enfant/kermesse-interaction-list';
  static const String kermesseInteractionDetails =
      '/enfant/kermesse-interaction-details';
  static const String kermesseTombolaList = '/enfant/kermesse-tombola-list';
  static const String kermesseTombolaDetails =
      '/enfant/kermesse-tombola-details';
  static const String ticketList = '/enfant/ticket-list';
  static const String ticketDetails = '/enfant/ticket-details';
}


class EnfantRouter {
  static StatefulShellRoute routes = StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) {
      return EnfantBottomNavigation(navigationShell: navigationShell);
    },
    branches: [
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: EnfantRoutes.userDetails,
            pageBuilder: (context, state) {
              AuthUser user =
                  Provider.of<AuthProvider>(context, listen: false).user;
              return NoTransitionPage(
                child: UserDetailsScreen(
                  userId: user.id,
                ),
              );
            },
          ),
          GoRoute(
            path: EnfantRoutes.userEdit,
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
            path: EnfantRoutes.kermesseList,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: KermesseListScreen(),
            ),
          ),
          GoRoute(
            path: EnfantRoutes.kermesseDetails,
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
            path: EnfantRoutes.kermesseStandList,
            pageBuilder: (context, state) {
              final params =
              GoRouterState.of(context).extra as Map<String, int>;
              return NoTransitionPage(
                child: KermesseStandListScreen(
                  kermesseId: params['kermesseId']!,
                ),
              );
            },
          ),
          GoRoute(
            path: EnfantRoutes.kermesseStandDetails,
            pageBuilder: (context, state) {
              final params =
              GoRouterState.of(context).extra as Map<String, int>;
              return NoTransitionPage(
                child: KermesseStandDetailsScreen(
                  kermesseId: params['kermesseId']!,
                  standId: params['standId']!,
                ),
              );
            },
          ),
          GoRoute(
            path: EnfantRoutes.kermesseInteractionList,
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
            path: EnfantRoutes.kermesseInteractionDetails,
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
          GoRoute(
            path: EnfantRoutes.kermesseTombolaList,
            pageBuilder: (context, state) {
              final params =
              GoRouterState.of(context).extra as Map<String, int>;
              return NoTransitionPage(
                child: KermesseTombolaListScreen(
                  kermesseId: params['kermesseId']!,
                ),
              );
            },
          ),
          GoRoute(
            path: EnfantRoutes.kermesseTombolaDetails,
            pageBuilder: (context, state) {
              final params =
              GoRouterState.of(context).extra as Map<String, int>;
              return NoTransitionPage(
                child: KermesseTombolaDetailsScreen(
                  kermesseId: params['kermesseId']!,
                  tombolaId: params['tombolaId']!,
                ),
              );
            },
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: EnfantRoutes.ticketList,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: TicketListScreen(),
            ),
          ),
          GoRoute(
            path: EnfantRoutes.ticketDetails,
            pageBuilder: (context, state) {
              final params =
              GoRouterState.of(context).extra as Map<String, int>;
              return NoTransitionPage(
                child: TicketDetailsScreen(
                  ticketId: params['ticketId']!,
                ),
              );
            },
          ),
        ],
      ),
    ],
  );
}
