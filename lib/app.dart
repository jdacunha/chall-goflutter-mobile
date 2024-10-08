import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chall_mobile/api/api_response.dart';
import 'package:chall_mobile/data/get_me_response.dart';
import 'package:chall_mobile/providers/auth_provider.dart';
import 'package:chall_mobile/router/app_router.dart';
import 'package:chall_mobile/services/auth_service.dart';

class App extends StatefulWidget {
  final AppRouter router;

  const App({
    super.key,
    required this.router,
  });

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _getMe();
  }

  Future<void> _getMe() async {
    ApiResponse<GetMeResponse> response = await _authService.getMe();
    if (response.error == null && response.data != null) {
      Provider.of<AuthProvider>(context, listen: false).setUser(
        response.data!.id,
        response.data!.name,
        response.data!.email,
        response.data!.role,
        response.data!.hasStand,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: widget.router.goRouter(context),
    );
  }
}
