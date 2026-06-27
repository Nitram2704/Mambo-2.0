import 'package:flutter/material.dart' hide Chip;
import 'package:google_fonts/google_fonts.dart';
import 'package:vitalis_app/core/theme/app_theme.dart';
import 'package:vitalis_app/core/widgets/common_widgets.dart';
import '../widgets/auth_widgets.dart';

class AuthInicioPage extends StatelessWidget {
  final void Function(String) onNavigate;
  final VoidCallback onFinished;

  const AuthInicioPage({
    super.key,
    required this.onNavigate,
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
              const BrandCircle(size: 100),
              const SizedBox(height: 24),
              Text(
                'Vitalis',
                style: GoogleFonts.cormorant(
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                  color: AppColors.accent,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Tu viaje fitness, en equilibrio.\nEntrena, duerme, aliméntate, conéctate.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
              const Spacer(flex: 2),
              AuthButton(
                text: 'Iniciar sesión',
                onPressed: () => onNavigate('login'),
              ),
              const SizedBox(height: 12),
              AuthButton(
                text: 'Crear cuenta',
                type: AppButtonType.secondary,
                onPressed: () => onNavigate('register'),
              ),
              const SizedBox(height: 16),
              const AuthDivider(),
              const SizedBox(height: 16),
              AuthGoogleButton(
                onPressed: () => onNavigate('plan'),
              ),
              const SizedBox(height: 12),
              AuthButton(
                text: 'Explorar sin cuenta',
                type: AppButtonType.ghost,
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
