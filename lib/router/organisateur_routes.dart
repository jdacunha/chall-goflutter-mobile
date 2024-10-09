import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../screens/organisateur/kermesse_create_screen.dart';
import '../screens/organisateur/kermesse_details_screen.dart';
import '../screens/organisateur/kermesse_edit_screen.dart';
import '../screens/organisateur/kermesse_interaction_details_screen.dart';
import '../screens/organisateur/kermesse_interaction_list_screen.dart';
import '../screens/organisateur/kermesse_list_screen.dart';
import '../screens/organisateur/kermesse_participant_invite_screen.dart';
import '../screens/organisateur/kermesse_stand_invite_screen.dart';
import '../screens/organisateur/kermesse_stand_list_screen.dart';
import '../screens/organisateur/kermesse_tombola_create_screen.dart';
import '../screens/organisateur/kermesse_tombola_details_screen.dart';
import '../screens/organisateur/kermesse_tombola_edit_screen.dart';
import '../screens/organisateur/kermesse_tombola_list_screen.dart';
import '../screens/organisateur/kermesse_user_list_screen.dart';
import '../screens/organisateur/ticket_details_screen.dart';
import '../screens/organisateur/ticket_list_screen.dart';
import '../screens/organisateur/user_edit_screen.dart';
import 'organisateur_bottom_navigation.dart';
import 'package:chall_mobile/providers/auth_provider.dart';
import 'package:chall_mobile/providers/auth_user.dart';

import 'package:chall_mobile/screens/organisateur/accueil_screen.dart';
import 'package:chall_mobile/screens/organisateur/profile_screen.dart';


class OrganisateurRoutes {
  static const String accueil = '/organisateur/accueil';
  static const String profile = '/organisateur/profile';
  static const String userEdit = '/organisateur/user-edit';
  static const String kermesseList = '/organisateur/kermesse-list';
  static const String kermesseDetails = '/organisateur/kermesse-details';
  static const String kermesseCreate = '/organisateur/kermesse-create';
  static const String kermesseEdit = '/organisateur/kermesse-edit';
  static const String kermesseDashboard = '/organisateur/kermesse-dashboard';
  static const String kermesseUserList = '/organisateur/kermesse-user-list';
  static const String kermesseParticipantInvite = '/organisateur/kermesse-participant-invite';
  static const String kermesseStandList = '/organisateur/kermesse-stand-list';
  static const String kermesseStandInvite = '/organisateur/kermesse-stand-invite';
  static const String kermesseTombolaList = '/organisateur/kermesse-tombola-list';
  static const String kermesseTombolaDetails =
      '/organisateur/kermesse-tombola-details';
  static const String kermesseTombolaCreate =
      '/organisateur/kermesse-tombola-create';
  static const String kermesseTombolaEdit = '/organisateur/kermesse-tombola-edit';
  static const String kermesseInteractionList =
      '/organisateur/kermesse-interaction-list';
  static const String kermesseInteractionDetails =
      '/organisateur/kermesse-interaction-details';
  static const String ticketList = '/organisateur/ticket-list';
  static const String ticketDetails = '/organisateur/ticket-details';
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
            path: OrganisateurRoutes.profile,
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
            path: OrganisateurRoutes.userEdit,
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
            path: OrganisateurRoutes.kermesseList,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: KermesseListScreen(),
            ),
          ),
          GoRoute(
            path: OrganisateurRoutes.kermesseDetails,
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
            path: OrganisateurRoutes.kermesseCreate,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: KermesseCreateScreen(),
            ),
          ),
          GoRoute(
            path: OrganisateurRoutes.kermesseEdit,
            pageBuilder: (context, state) {
              final params =
              GoRouterState.of(context).extra as Map<String, int>;
              return NoTransitionPage(
                child: KermesseEditScreen(
                  kermesseId: params['kermesseId']!,
                ),
              );
            },
          ),
          /* ------
          GoRoute(
            path: OrganisateurRoutes.kermesseDashboard,
            pageBuilder: (context, state) {
              final params =
              GoRouterState.of(context).extra as Map<String, int>;
              return NoTransitionPage(
                child: KermesseDashboardScreen(
                  kermesseId: params['kermesseId']!,
                ),
              );
            },
          ), ------  */
          GoRoute(
            path: OrganisateurRoutes.kermesseUserList,
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
            path: OrganisateurRoutes.kermesseParticipantInvite,
            pageBuilder: (context, state) {
              final params =
              GoRouterState.of(context).extra as Map<String, int>;
              return NoTransitionPage(
                child: KermesseParticipantInviteScreen(
                  kermesseId: params['kermesseId']!,
                ),
              );
            },
          ),
          GoRoute(
            path: OrganisateurRoutes.kermesseStandList,
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
            path: OrganisateurRoutes.kermesseStandInvite,
            pageBuilder: (context, state) {
              final params =
              GoRouterState.of(context).extra as Map<String, int>;
              return NoTransitionPage(
                child: KermesseStandInviteScreen(
                  kermesseId: params['kermesseId']!,
                ),
              );
            },
          ),
          GoRoute(
            path: OrganisateurRoutes.kermesseTombolaList,
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
            path: OrganisateurRoutes.kermesseTombolaDetails,
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
          GoRoute(
            path: OrganisateurRoutes.kermesseTombolaCreate,
            pageBuilder: (context, state) {
              final params =
              GoRouterState.of(context).extra as Map<String, int>;
              return NoTransitionPage(
                child: KermesseTombolaCreateScreen(
                  kermesseId: params['kermesseId']!,
                ),
              );
            },
          ),
          GoRoute(
            path: OrganisateurRoutes.kermesseTombolaEdit,
            pageBuilder: (context, state) {
              final params =
              GoRouterState.of(context).extra as Map<String, int>;
              return NoTransitionPage(
                child: KermesseTombolaEditScreen(
                  kermesseId: params['kermesseId']!,
                  tombolaId: params['tombolaId']!,
                ),
              );
            },
          ),
          GoRoute(
            path: OrganisateurRoutes.kermesseInteractionList,
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
            path: OrganisateurRoutes.kermesseInteractionDetails,
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
            path: OrganisateurRoutes.ticketList,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: TicketListScreen(),
            ),
          ),
          GoRoute(
            path: OrganisateurRoutes.ticketDetails,
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
