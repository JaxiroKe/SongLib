import 'package:flutter/material.dart';

import 'theme_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme() {
    return ThemeData(
      scaffoldBackgroundColor: ThemeColors.accent1,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: ThemeColors.primary,
        onPrimary: Colors.white,
        primaryContainer: ThemeColors.primary,
        secondary: ThemeColors.primary1,
        onSecondary: Colors.grey,
        secondaryContainer: ThemeColors.primary1,
        surface: Colors.white,
        onSurface: Colors.black,
        error: Colors.red,
        onError: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: ThemeColors.primary,
        foregroundColor: ThemeColors.accent,
        shadowColor: Colors.black,
        elevation: 3,
      ),
      navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: Colors.white,
        indicatorColor: ThemeColors.accent,
        elevation: 3,
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      scaffoldBackgroundColor: ThemeColors.primaryDark1,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: ThemeColors.primary2,
        onPrimary: ThemeColors.primaryDark1,
        primaryContainer: ThemeColors.primaryDark,
        secondary: ThemeColors.primaryDark1,
        onSecondary: ThemeColors.primaryDark1,
        secondaryContainer: ThemeColors.primaryDark1,
        surface: ThemeColors.primaryDark,
        onSurface: Colors.white,
        error: Colors.red,
        onError: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: ThemeColors.primaryDark1,
        foregroundColor: Colors.white,
        shadowColor: Colors.black,
        elevation: 3,
      ),
      navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: Colors.white,
        indicatorColor: ThemeColors.accent,
        elevation: 3,
      ),
    );
  }
}