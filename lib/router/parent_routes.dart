import 'package:chall_mobile/router/parent_bottom_navigation.dart';
import 'package:chall_mobile/screens/parent/accueil_screen.dart';
import 'package:chall_mobile/screens/parent/user_jeton_edit_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:chall_mobile/providers/auth_provider.dart';
import 'package:chall_mobile/providers/auth_user.dart';

import 'package:provider/provider.dart';

import '../screens/parent/children_details_screen.dart';
import '../screens/parent/children_invite_screen.dart';
import '../screens/parent/children_list_screen.dart';
import '../screens/parent/kermesse_details_screen.dart';
import '../screens/parent/kermesse_interaction_details_screen.dart';
import '../screens/parent/kermesse_interaction_list_screen.dart';
import '../screens/parent/kermesse_list_screen.dart';
import '../screens/parent/kermesse_stand_details_screen.dart';
import '../screens/parent/kermesse_stand_list_screen.dart';
import '../screens/parent/kermesse_user_list_screen.dart';
import '../screens/parent/ticket_list_screen.dart';
import '../screens/parent/ticket_details_screen.dart';
import '../screens/parent/user_edit_screen.dart';
import '../screens/parent/user_details_screen.dart';

class ParentRoutes {
  static const String accueil = '/parent/accueil';
  static const String userDetails = '/parent/user-details';
  static const String userEdit = '/parent/user-edit';
  static const String userJetonEdit = '/parent/user-jeton-edit';
  static const String kermesseList = '/parent/kermesse-list';
  static const String kermesseDetails = '/parent/kermesse-details';
  static const String kermesseDashboard = '/parent/kermesse-dashboard';
  static const String kermesseUserList = '/parent/kermesse-user-list';
  static const String kermesseStandList = '/parent/kermesse-stand-list';
  static const String kermesseStandDetails = '/parent/kermesse-stand-details';
  static const String kermesseInteractionList =
      '/parent/kermesse-interaction-list';
  static const String kermesseInteractionDetails =
      '/parent/kermesse-interaction-details';
  static const String ticketList = '/parent/ticket-list';
  static const String ticketDetails = '/parent/ticket-details';
  static const String childrenList = '/parent/children-list';
  static const String childrenDetails = '/parent/children-details';
  static const String childrenInvite = '/parent/children-invite';
}


class ParentRouter {
  static StatefulShellRoute routes = StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) {
      return ParentBottomNavigation(navigationShell: navigationShell);
    },
    branches: [
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: ParentRoutes.userDetails,
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
            path: ParentRoutes.userEdit,
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
          GoRoute(
            path: ParentRoutes.userJetonEdit,
            pageBuilder: (context, state) {
              AuthUser user =
                  Provider.of<AuthProvider>(context, listen: false).user;
              return NoTransitionPage(
                child: UserJetonEditScreen(
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
            path: ParentRoutes.kermesseList,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: KermesseListScreen(),
            ),
          ),
          GoRoute(
            path: ParentRoutes.kermesseDetails,
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
            path: ParentRoutes.kermesseUserList,
            pageBuilder: (context, state) {
              final params =
              GoRouterState.of(context).extra as Map<String, int>;
              return NoTransitionPage(
                child: KermesseUserListScreen(
                  kermesseId: params['kermesseId']!,
                ),
              );
            },
          ),
          GoRoute(
            path: ParentRoutes.kermesseStandList,
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
            path: ParentRoutes.kermesseStandDetails,
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
            path: ParentRoutes.kermesseInteractionList,
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
            path: ParentRoutes.kermesseInteractionDetails,
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
            path: ParentRoutes.childrenList,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ChildrenListScreen(),
            ),
          ),
          GoRoute(
            path: ParentRoutes.childrenDetails,
            pageBuilder: (context, state) {
              final params =
              GoRouterState.of(context).extra as Map<String, int>;
              return NoTransitionPage(
                child: ChildrenDetailsScreen(
                  userId: params['userId']!,
                ),
              );
            },
          ),
          GoRoute(
            path: ParentRoutes.childrenInvite,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ChildrenInviteScreen(),
            ),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: ParentRoutes.ticketList,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: TicketListScreen(),
            ),
          ),
          GoRoute(
            path: ParentRoutes.ticketDetails,
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
