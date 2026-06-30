import 'package:flutter/material.dart' hide Chip;
import 'package:vitalis_app/app.dart';
import 'package:vitalis_app/core/widgets/common_widgets.dart';
import 'package:vitalis_app/core/theme/app_theme.dart';
import 'package:vitalis_app/core/widgets/toast.dart';
import '../../domain/entities/user.dart';
import '../widgets/home_widgets.dart';

class HomeProfilePage extends StatelessWidget {
  final User user;
  final void Function(String) onNavigate;

  const HomeProfilePage({
    super.key,
    required this.user,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 8),
            ProfileHeader(
              user: user,
              onEdit: () => onNavigate('editar-perfil'),
            ),
            const SizedBox(height: 24),
            _ProfileStats(user: user),
            const SizedBox(height: 24),
            const _Achievements(),
            const SizedBox(height: 24),
            const _Preferences(),
            const SizedBox(height: 24),
            _logoutButton(context),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _ProfileStats extends StatelessWidget {
  final User user;
  const _ProfileStats({required this.user});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        children: [
          Row(children: [
            _profileStatItem('Peso', '${user.peso} kg'),
            _profileStatItem('Altura', '${user.altura} m'),
          ]),
          const SizedBox(height: 8),
          Container(height: 1, color: AppColors.border.withOpacity(0.15)),
          const SizedBox(height: 8),
          Row(children: [
            _profileStatItem('Entrenos', '${user.entrenos}'),
            _profileStatItem('Completitud', '${user.completitud}%'),
          ]),
        ],
      ),
    );
  }

  Widget _profileStatItem(String label, String value) {
    return Expanded(
      child: Column(children: [
        Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.accent, height: 1.1)),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
      ]),
    );
  }
}

class _Achievements extends StatelessWidget {
  const _Achievements();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(text: 'Logros'),
        const SizedBox(height: 4),
        Row(children: [
          Expanded(child: _achievementCard('Racha', '7', Icons.local_fire_department, false)),
          const SizedBox(width: 8),
          Expanded(child: _achievementCard('Amigos', '50', Icons.lock, true)),
          const SizedBox(width: 8),
          Expanded(child: _achievementCard('Entrenos', '100', Icons.lock, true)),
        ]),
      ],
    );
  }

  Widget _achievementCard(String title, String value, IconData icon, bool locked) {
    return AppCard(
      padding: const EdgeInsets.all(12),
      child: Column(children: [
        Icon(icon, color: locked ? AppColors.textTertiary : AppColors.accent, size: 22),
        const SizedBox(height: 6),
        Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: locked ? AppColors.textTertiary : AppColors.text, height: 1.1)),
        const SizedBox(height: 2),
        Text(title, style: TextStyle(fontSize: 10, color: locked ? AppColors.textTertiary : AppColors.textSecondary)),
      ]),
    );
  }
}

class _Preferences extends StatelessWidget {
  const _Preferences();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(text: 'Preferencias'),
        ToggleRow(label: 'Recordatorios', subLabel: 'Recibe notificaciones de rutinas', value: true, onChanged: (_) {}),
        ToggleRow(label: 'Perfil público', subLabel: 'Visible para otros usuarios', value: true, onChanged: (_) {}),
        ToggleRow(label: 'Modo oscuro', subLabel: 'Tema oscuro del sistema', value: true, onChanged: (_) {}),
        ToggleRow(label: 'Sonido', subLabel: 'Efectos de sonido en la app', value: false, onChanged: (_) {}),
      ],
    );
  }
}

Widget _logoutButton(BuildContext context) {
  return SizedBox(
    width: double.infinity,
    child: TextButton(
      onPressed: () {
        ToastOverlayState.of(context)?.show('Cerrando sesión...');
        Future.delayed(const Duration(milliseconds: 800), () {
          if (context.mounted) {
            context.findAncestorStateOfType<VitalisAppState>()?.logout();
          }
        });
      },
      style: TextButton.styleFrom(
        foregroundColor: AppColors.accentRose,
        side: BorderSide(color: AppColors.accentRose.withOpacity(0.4)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.logout, size: 16, color: AppColors.accentRose),
          const SizedBox(width: 8),
          const Text('Cerrar sesión', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.accentRose)),
        ],
      ),
    ),
  );
}
