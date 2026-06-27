import 'package:flutter/material.dart' hide Chip;
import 'package:google_fonts/google_fonts.dart';
import 'package:vitalis_app/core/theme/app_theme.dart';
import '../widgets/auth_widgets.dart';

class AuthWelcomePage extends StatelessWidget {
  final VoidCallback onFinished;

  const AuthWelcomePage({
    super.key,
    required this.onFinished,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const Spacer(flex: 3),
              const BrandCircle(size: 100, animated: true),
              const SizedBox(height: 24),
              Text(
                '¡Bienvenido a Vitalis!',
                style: GoogleFonts.cormorant(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: AppColors.accent,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Tu cuenta está lista.\nEmpieza tu viaje fitness ahora.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
              const Spacer(flex: 2),
              AuthButton(
                text: 'Ir a la aplicación',
                onPressed: onFinished,
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
