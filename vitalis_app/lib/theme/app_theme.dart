import 'package:flutter/material.dart';

class AppColors {
  static const bg = Color(0xFF0F0F0F);
  static const surface = Color(0x0FE8B4B8);
  static const surfaceHover = Color(0x1FE8B4B8);
  static const elevated = Color(0x1FB89066);
  static const text = Color(0xFFE8E4DF);
  static const textSecondary = Color(0xFF9A9590);
  static const textTertiary = Color(0xFF9A9590);
  static const accent = Color(0xFFD4A574);
  static const accentRose = Color(0xFFE8B4B8);
  static const border = Color(0xFFB89066);
  static const error = Color(0xFFE8B4B8);
  static const success = Color(0xFFD4A574);
}

class AppTheme {
  static ThemeData get dark {
    const c = AppColors;
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: c.bg,
      colorScheme: const ColorScheme.dark(
        primary: c.accent,
        secondary: c.accentRose,
        surface: c.bg,
        onSurface: c.text,
        onPrimary: c.bg,
        error: c.error,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: c.accent,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.01,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xF50F0F0F),
        selectedItemColor: c.accent,
        unselectedItemColor: c.textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      dividerTheme: const DividerThemeData(
        color: Color(0x26B89066),
        thickness: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: c.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: c.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: c.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: c.accent, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: c.error),
        ),
        labelStyle: const TextStyle(color: c.textSecondary, fontSize: 13, fontWeight: FontWeight.w600),
        hintStyle: const TextStyle(color: c.textTertiary),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      ),
    );
  }
}
