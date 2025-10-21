import 'package:flutter/material.dart';

class AppTheme {
  static const _seed = Color(0xFF3A0CA3);

  static ThemeData get light {
    final scheme = ColorScheme.fromSeed(
      seedColor: _seed,
      brightness: Brightness.light,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: const Color(0xFFF7F9FC),
      fontFamily: 'SF Pro Display',
      textTheme: _textTheme,
      appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  static ThemeData get dark {
    final scheme = ColorScheme.fromSeed(
      seedColor: _seed,
      brightness: Brightness.dark,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      textTheme: _textTheme,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  static const _textTheme = TextTheme(
    displayLarge: TextStyle(fontWeight: FontWeight.w700, letterSpacing: -0.5),
    headlineMedium: TextStyle(fontWeight: FontWeight.w700),
    bodyLarge: TextStyle(height: 1.4),
    bodyMedium: TextStyle(height: 1.4),
    labelLarge: TextStyle(fontWeight: FontWeight.w600),
  );
}
