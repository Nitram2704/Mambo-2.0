import 'package:flutter/material.dart' hide Chip;
import 'package:vitalis_app/core/widgets/common_widgets.dart';
import 'package:vitalis_app/core/theme/app_theme.dart';
import 'package:vitalis_app/features/nutrition/domain/repositories/nutrition_repository.dart';

class NutritionHistoryPage extends StatelessWidget {
  final VoidCallback onGoBack;
  final List<NutritionHistoryEntry> history;
  const NutritionHistoryPage({
    super.key,
    required this.onGoBack,
    required this.history,
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
        title: const Text('Historial'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: history.asMap().entries.map((e) {
          final h = e.value;
          final pillType = h.pillType == 'warning'
              ? PillType.warning
              : h.pillType == 'error'
                  ? PillType.error
                  : PillType.success;
          return Padding(
            padding: EdgeInsets.only(bottom: e.key < history.length - 1 ? 12 : 0),
            child: _historyCard(h.label, h.kcal, pillType, h.macros),
          );
        }).toList(),
      ),
    );
  }

  Widget _historyCard(
      String label, int kcal, PillType type, List<(String, int)> macros) {
    return AppCard(
      child: Column(
        children: [
          Row(
            children: [
              Text(label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.text,
                  )),
              const Spacer(),
              Text('$kcal kcal',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.text,
                  )),
              const SizedBox(width: 8),
              Pill(
                text: kcal <= 2000 ? 'Meta cumplida' : 'Excedido',
                type: type,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: macros
                .map((m) => Expanded(child: _macroStat(m.$1, m.$2)))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _macroStat(String label, int grams) {
    return Column(
      children: [
        Text('$grams',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.accent,
            )),
        const SizedBox(height: 2),
        const Text('g',
            style: TextStyle(
              fontSize: 11,
              color: AppColors.textSecondary,
            )),
        const SizedBox(height: 2),
        Text(label,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.textSecondary,
            )),
      ],
    );
  }
}
