import 'package:go_router/go_router.dart';
import 'package:chall_mobile/screens/auth/login_screen.dart';
import 'package:chall_mobile/screens/auth/register_screen.dart';


class AuthRoutes {
  static const String login = '/auth/login';
  static const String register = '/auth/register';
}

class AuthRouter {
  static List<RouteBase> routes = [
    GoRoute(
      path: AuthRoutes.login,
      pageBuilder: (context, state) => const NoTransitionPage(
        child: LoginScreen(),
      ),
    ),
    GoRoute(
      path: AuthRoutes.register,
      pageBuilder: (context, state) => const NoTransitionPage(
        child: RegisterScreen(),
      ),
    ),
  ];
}
