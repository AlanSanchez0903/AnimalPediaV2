import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color _background = Color(0xFF121212);
  static const Color _surface = Color(0xFF1E1E1E);
  static const Color _primary = Color(0xFF9FA8DA);

  static ThemeData get darkTheme {
    final base = ThemeData.dark(useMaterial3: true);

    return base.copyWith(
      scaffoldBackgroundColor: _background,
      colorScheme: base.colorScheme.copyWith(
        brightness: Brightness.dark,
        primary: _primary,
        surface: _surface,
      ),
      textTheme: base.textTheme.apply(
        fontFamily: 'Poppins',
        bodyColor: Colors.white,
        displayColor: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: _surface,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        color: _surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
