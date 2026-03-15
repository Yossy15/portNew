import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_theme.g.dart';

class AppThemeData {
  AppThemeData({
    required this.lightTheme,
    required this.darkTheme,
    required this.themeMode,
  });

  final ThemeData lightTheme;
  final ThemeData darkTheme;
  final ThemeMode themeMode;
}

@riverpod
AppThemeData appTheme(AppThemeRef ref) {
  final baseTextTheme = GoogleFonts.itimTextTheme();

  final colorSchemeLight = ColorScheme.fromSeed(
    seedColor: const Color(0xFF00BFA6),
    brightness: Brightness.light,
  );
  final colorSchemeDark = ColorScheme.fromSeed(
    seedColor: const Color(0xFF00BFA6),
    brightness: Brightness.dark,
  );

  final light = ThemeData(
    colorScheme: colorSchemeLight,
    useMaterial3: true,
    textTheme: baseTextTheme,
    scaffoldBackgroundColor: const Color(0xFFF5F5F7),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: false,
    ),
    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  );

  final dark = ThemeData(
    colorScheme: colorSchemeDark,
    useMaterial3: true,
    textTheme: baseTextTheme.apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),
    scaffoldBackgroundColor: const Color(0xFF050814),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: false,
      backgroundColor: Colors.transparent,
    ),
    cardTheme: CardThemeData(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  );

  return AppThemeData(
    lightTheme: light,
    darkTheme: dark,
    themeMode: ThemeMode.system,
  );
}
