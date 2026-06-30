import 'package:flutter/material.dart' hide Chip;
import 'package:vitalis_app/core/widgets/common_widgets.dart';
import 'package:vitalis_app/core/theme/app_theme.dart';
import 'package:vitalis_app/core/widgets/toast.dart';

class NutritionSelectPage extends StatefulWidget {
  final VoidCallback onGoBack;
  const NutritionSelectPage({super.key, required this.onGoBack});
  @override
  State<NutritionSelectPage> createState() => _NutritionSelectPageState();
}

class _NutritionSelectPageState extends State<NutritionSelectPage> {
  final _portionController = TextEditingController(text: '100');
  double _portionGrams = 100;

  final _food = (
    name: 'Pollo pechuga',
    kcal: 165,
    protein: 31.0,
    carbs: 0.0,
    fat: 3.6,
  );

  @override
  void dispose() {
    _portionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final factor = _portionGrams / 100;

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.text),
          onPressed: widget.onGoBack,
        ),
        title: const Text('Seleccionar'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AppCard(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.accent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.restaurant_outlined,
                          color: AppColors.accent, size: 24),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_food.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.text,
                              )),
                          const SizedBox(height: 2),
                          Text('${_food.kcal} kcal',
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.textSecondary,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Divider(),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _macroChip('Proteínas', '${_food.protein}g'),
                    const SizedBox(width: 8),
                    _macroChip('Carbohidratos', '${_food.carbs}g'),
                    const SizedBox(width: 8),
                    _macroChip('Grasas', '${_food.fat}g'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const SectionTitle(text: 'Porción'),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _portionController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Cantidad',
                  ),
                  style: const TextStyle(
                      color: AppColors.text, fontSize: 15),
                  onChanged: (v) {
                    setState(() {
                      _portionGrams = double.tryParse(v) ?? 0;
                    });
                  },
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  border: Border.all(color: AppColors.border),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text('g',
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.textSecondary,
                    )),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: StatCard(
                  value: '${(_food.kcal * factor).round()}',
                  label: 'kcal',
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: StatCard(
                  value:
                      (_food.protein * factor).toStringAsFixed(1),
                  label: 'Proteínas (g)',
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: StatCard(
                  value:
                      (_food.carbs * factor).toStringAsFixed(1),
                  label: 'Carbohidratos (g)',
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: StatCard(
                  value: (_food.fat * factor).toStringAsFixed(1),
                  label: 'Grasas (g)',
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          AppButton(
            text: 'Añadir a comida',
            onPressed: () {
              ToastOverlayState.of(context)
                  ?.show('Añadido a la comida');
            },
          ),
        ],
      ),
    );
  }

  Widget _macroChip(String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          children: [
            Text(value,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.accent,
                )),
            Text(label,
                style: const TextStyle(
                  fontSize: 10,
                  color: AppColors.textSecondary,
                )),
          ],
        ),
      ),
    );
  }
}
