import 'package:flutter/material.dart' hide Chip;
import 'package:google_fonts/google_fonts.dart';
import 'package:vitalis_app/core/theme/app_theme.dart';
import 'package:vitalis_app/core/widgets/toast.dart';
import '../../data/mock_auth_repository.dart';
import '../widgets/auth_widgets.dart';

class AuthRegisterPage extends StatefulWidget {
  final void Function(String) onNavigate;
  final VoidCallback onBack;

  const AuthRegisterPage({
    super.key,
    required this.onNavigate,
    required this.onBack,
  });

  @override
  State<AuthRegisterPage> createState() => _AuthRegisterPageState();
}

class _AuthRegisterPageState extends State<AuthRegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  final _repo = MockAuthRepository();
  bool _loading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) return 'El nombre es requerido';
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'El email es requerido';
    if (!value.contains('@')) return 'Email inválido';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'La contraseña es requerida';
    if (value.length < 8) return 'Mínimo 8 caracteres';
    return null;
  }

  String? _validateConfirm(String? value) {
    if (value == null || value.isEmpty) return 'Confirma tu contraseña';
    if (value != _passwordController.text) return 'Las contraseñas no coinciden';
    return null;
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    try {
      await _repo.register(
        _nameController.text.trim(),
        _emailController.text.trim(),
        _passwordController.text,
      );
      if (mounted) ToastOverlayState.of(context)?.show('Cuenta creada');
    } catch (_) {
      if (mounted) ToastOverlayState.of(context)?.show('Error al crear cuenta');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          onPressed: widget.onBack,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Text(
                  'Crear cuenta',
                  style: GoogleFonts.cormorant(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: AppColors.accent,
                  ),
                ),
                const SizedBox(height: 24),
                AuthInputField(
                  label: 'Nombre completo',
                  controller: _nameController,
                  validator: _validateName,
                ),
                const SizedBox(height: 16),
                AuthInputField(
                  label: 'Email',
                  hint: 'tu@email.com',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: _validateEmail,
                ),
                const SizedBox(height: 16),
                AuthInputField(
                  label: 'Contraseña',
                  hint: '••••••••',
                  controller: _passwordController,
                  obscure: true,
                  validator: _validatePassword,
                ),
                const SizedBox(height: 4),
                const Text(
                  'Mínimo 8 caracteres',
                  style: TextStyle(fontSize: 12, color: AppColors.textTertiary),
                ),
                const SizedBox(height: 16),
                AuthInputField(
                  label: 'Confirmar contraseña',
                  hint: '••••••••',
                  controller: _confirmController,
                  obscure: true,
                  validator: _validateConfirm,
                ),
                const SizedBox(height: 24),
                AuthButton(
                  text: 'Crear cuenta',
                  loading: _loading,
                  onPressed: _handleRegister,
                ),
                const SizedBox(height: 20),
                const AuthDivider(),
                const SizedBox(height: 20),
                AuthGoogleButton(
                  onPressed: () => widget.onNavigate('plan'),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '¿Ya tienes cuenta? ',
                      style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
                    ),
                    GestureDetector(
                      onTap: () => widget.onNavigate('login'),
                      child: const Text(
                        'Inicia sesión',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.accent,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
