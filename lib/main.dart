import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chall_mobile/app.dart';
import 'package:chall_mobile/providers/auth_provider.dart';
import 'package:chall_mobile/router/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: App(
        router: AppRouter(),
      ),
    ),
  );
}
