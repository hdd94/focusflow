// lib/shared/theme/app_theme.dart
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get theme => ThemeData(
        platform: TargetPlatform.macOS,
        primaryColor: const Color.fromARGB(100, 28, 184, 220),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(100, 28, 184, 220),
          secondary: Colors.cyan.shade700,
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontFamily: 'Aleo',
            fontSize: 48,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: Colors.black87,
          ),
          headlineMedium: TextStyle(
            fontFamily: 'Aleo',
            fontSize: 32,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            color: Colors.black87,
          ),
          bodyLarge: TextStyle(
            // Default font family is Roboto
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.cyan, width: 2),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(100, 28, 184, 220),
          ),
        ),
      );
}
