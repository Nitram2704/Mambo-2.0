import 'package:flutter/material.dart' hide Chip;
import 'package:vitalis_app/core/widgets/common_widgets.dart';
import 'package:vitalis_app/core/theme/app_theme.dart';

class NutritionRegisterPage extends StatelessWidget {
  final void Function(String) onNavigate;
  final VoidCallback onGoBack;
  const NutritionRegisterPage({
    super.key,
    required this.onNavigate,
    required this.onGoBack,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.text),
          onPressed: onGoBack,
        ),
        title: const Text('Registrar alimento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _optionCard(
              icon: Icons.camera_alt_outlined,
              title: 'Foto',
              desc: 'Toma una foto a tu comida',
              onTap: () {},
            ),
            const SizedBox(height: 12),
            _optionCard(
              icon: Icons.qr_code_scanner_outlined,
              title: 'Código de barras',
              desc: 'Escanea el código de barras del producto',
              onTap: () => onNavigate('barcode'),
            ),
            const SizedBox(height: 12),
            _optionCard(
              icon: Icons.edit_note_outlined,
              title: 'Manual',
              desc: 'Ingresa los datos manualmente',
              onTap: () => onNavigate('manual'),
            ),
            const SizedBox(height: 12),
            _optionCard(
              icon: Icons.storage_outlined,
              title: 'Base de datos',
              desc: 'Busca en nuestra base de datos',
              onTap: () => onNavigate('buscar'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _optionCard({
    required IconData icon,
    required String title,
    required String desc,
    required VoidCallback onTap,
  }) {
    return AppCard(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.accent, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.text,
                    )),
                const SizedBox(height: 2),
                Text(desc,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    )),
              ],
            ),
          ),
          const Icon(Icons.chevron_right,
              color: AppColors.textTertiary, size: 20),
        ],
      ),
    );
  }
}
