import 'package:flutter/material.dart' hide Chip;
import 'package:vitalis_app/core/widgets/common_widgets.dart';
import 'package:vitalis_app/core/theme/app_theme.dart';
import '../../domain/entities/user.dart';

class HomeEditProfilePage extends StatefulWidget {
  final User user;
  final VoidCallback onGoBack;
  final void Function(String name, String email, double peso, double altura, String username) onSaved;

  const HomeEditProfilePage({
    super.key,
    required this.user,
    required this.onGoBack,
    required this.onSaved,
  });

  @override
  State<HomeEditProfilePage> createState() => _HomeEditProfilePageState();
}

class _HomeEditProfilePageState extends State<HomeEditProfilePage> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _usernameController;
  late final TextEditingController _pesoController;
  late final TextEditingController _alturaController;
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  late bool _adulto;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _emailController = TextEditingController(text: widget.user.email);
    _usernameController = TextEditingController(text: widget.user.username);
    _pesoController = TextEditingController(text: '${widget.user.peso}');
    _alturaController = TextEditingController(text: '${widget.user.altura}');
    _adulto = widget.user.isAdult;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _pesoController.dispose();
    _alturaController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _save() {
    widget.onSaved(
      _nameController.text,
      _emailController.text,
      double.tryParse(_pesoController.text.replaceAll(',', '.')) ?? 0,
      double.tryParse(_alturaController.text.replaceAll(',', '.')) ?? 0,
      _usernameController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 8),
            _buildTopBar(),
            const SizedBox(height: 24),
            _buildAvatarSection(),
            const SizedBox(height: 28),
            _buildFormFields(),
            const SizedBox(height: 24),
            _buildPasswordSection(),
            const SizedBox(height: 28),
            AppButton(text: 'Guardar cambios', type: AppButtonType.primary, onPressed: _save),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      children: [
        TextButton(
          onPressed: widget.onGoBack,
          style: TextButton.styleFrom(foregroundColor: AppColors.textSecondary, padding: const EdgeInsets.symmetric(horizontal: 8)),
          child: const Text('Cancelar', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        ),
        const Spacer(),
        const Text('Editar perfil', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.text, letterSpacing: -0.01)),
        const Spacer(),
        GestureDetector(
          onTap: _save,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(20)),
            child: const Text('Guardar', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF0F0F0F))),
          ),
        ),
      ],
    );
  }

  Widget _buildAvatarSection() {
    return Center(
      child: Stack(
        children: [
          const AvatarCircle(letters: 'V', size: 72),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                color: AppColors.accent,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.bg, width: 2),
              ),
              child: const Icon(Icons.camera_alt, color: Color(0xFF0F0F0F), size: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormFields() {
    return Column(
      children: [
        _buildField('Nombre', _nameController),
        const SizedBox(height: 14),
        _buildField('Email', _emailController),
        const SizedBox(height: 14),
        _buildAgeSelector(),
        const SizedBox(height: 14),
        _buildField('Peso (kg)', _pesoController),
        const SizedBox(height: 14),
        _buildField('Altura (m)', _alturaController),
        const SizedBox(height: 14),
        _buildField('Usuario', _usernameController),
      ],
    );
  }

  Widget _buildField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      style: const TextStyle(color: AppColors.text, fontSize: 14),
    );
  }

  Widget _buildAgeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: Text('Edad', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
        ),
        Row(children: [
          Chip(text: 'Adulto', selected: _adulto, onTap: () => setState(() { _adulto = true; })),
          const SizedBox(width: 10),
          Chip(text: 'Adolescente', selected: !_adulto, onTap: () => setState(() { _adulto = false; })),
        ]),
      ],
    );
  }

  Widget _buildPasswordSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(text: 'Cambiar contraseña'),
        const SizedBox(height: 4),
        _buildField('Contraseña actual', _currentPasswordController),
        const SizedBox(height: 14),
        _buildField('Nueva contraseña', _newPasswordController),
        const SizedBox(height: 14),
        _buildField('Confirmar contraseña', _confirmPasswordController),
      ],
    );
  }
}
