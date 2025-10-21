import 'package:flutter/material.dart';
import 'src/router/app_router.dart';
import 'src/theme/app_theme.dart';

class PrefKeys {
  static const seenOnboarding = 'seen_onboarding_v1';
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(FlowlyApp());
}

class FlowlyApp extends StatelessWidget {
  const FlowlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flowly',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      initialRoute: AppRouter.onboarding,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
