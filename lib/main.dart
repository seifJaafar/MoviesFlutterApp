import 'package:flutter/material.dart';
import 'app/routers/app_router.dart';
import 'app/theme/theme.dart';
import 'app/services/firebase_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required before async calls in main
  await FirebaseService.initialize(); // Initialize Firebase

  runApp(
      const ProviderScope(child : MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies App (Auth UI)',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: AppRouter.onboarding,
      routes: AppRouter.routes,
    );
  }
}
