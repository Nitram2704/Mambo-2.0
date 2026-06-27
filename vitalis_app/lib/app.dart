import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/theme/app_theme.dart';
import 'shared/vitalis_shell.dart';
import 'features/auth/presentation/auth_screen.dart';

class VitalisApp extends StatefulWidget {
  const VitalisApp({super.key});

  @override
  State<VitalisApp> createState() => _VitalisAppState();
}

class _VitalisAppState extends State<VitalisApp> {
  bool _authenticated = false;

  void _onAuthFinished() {
    setState(() { _authenticated = true; });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.cormorantTextTheme(ThemeData.dark().textTheme);

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
      home: _authenticated
          ? const VitalisShell()
          : AuthScreens(onFinished: _onAuthFinished),
    );
  }
}
