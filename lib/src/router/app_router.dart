import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/onboarding_screen.dart';

class AppRouter {
  static const home = '/';
  static const onboarding = '/onboarding';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return _fwd(const HomeScreen());
      case onboarding:
        return _slide(const OnboardingScreen());
      default:
        return _fwd(const HomeScreen());
    }
  }

  static PageRoute _fwd(Widget child) =>
      MaterialPageRoute(builder: (_) => child);

  static PageRoute _slide(Widget child) {
    return PageRouteBuilder(
      pageBuilder: (_, anim, __) => child,
      transitionsBuilder: (_, anim, __, child) {
        final offset = Tween(
          begin: const Offset(0, 0.05),
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeOutCubic)).animate(anim);

        final fade = Tween(begin: 0.0, end: 1.0).animate(anim);

        return FadeTransition(
          opacity: fade,
          child: SlideTransition(position: offset, child: child),
        );
      },
    );
  }
}
