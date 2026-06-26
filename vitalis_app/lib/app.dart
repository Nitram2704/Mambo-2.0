import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme/app_theme.dart';

class VitalisApp extends StatelessWidget {
  const VitalisApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.cormorantTextTheme(
      ThemeData.dark().textTheme,
      fontWeight: FontWeight.w400,
    );

    return MaterialApp(
      title: 'Vitalis',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark.copyWith(
        textTheme: textTheme.copyWith(
          displayLarge: textTheme.displayLarge?.copyWith(fontWeight: FontWeight.w700),
          displayMedium: textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w700),
          displaySmall: textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w700),
          headlineLarge: textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w700),
          headlineMedium: textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
          headlineSmall: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
          titleLarge: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
          titleMedium: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          bodyLarge: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400),
          bodyMedium: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),
          labelLarge: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
          labelSmall: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      home: const PhoneFrame(),
    );
  }
}
