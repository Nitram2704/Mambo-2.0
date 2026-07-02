import 'package:flutter/material.dart' hide Chip;
import 'package:vitalis_app/core/widgets/common_widgets.dart';
import 'package:vitalis_app/core/theme/app_theme.dart';
import 'package:vitalis_app/features/nutrition/domain/entities/meal_template.dart';
import '../widgets/nutrition_widgets.dart';

class NutritionMainPage extends StatefulWidget {
  final void Function(String) onNavigate;
  const NutritionMainPage({super.key, required this.onNavigate});
  @override
  State<NutritionMainPage> createState() => _NutritionMainPageState();
}

class _NutritionMainPageState extends State<NutritionMainPage> {
  int _selectedDay = 4;

  final _days = <(String, String, bool)>[
    ('L', '22', false),
    ('M', '23', false),
    ('M', '24', false),
    ('J', '25', false),
    ('V', '26', false),
    ('S', '27', true),
    ('D', '28', false),
  ];

  final List<MealTemplate> _mealTemplates = MealTemplate.defaults();
  final List<MealTemplate> _activeMeals = MealTemplate.defaults();

  List<MealTemplate> get _availableTemplates => _mealTemplates
      .where((t) => !_activeMeals.any((a) => a.type == t.type))
      .toList();

  void _removeMeal(int index) {
    final removed = _activeMeals[index];
    setState(() {
      _activeMeals.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${removed.type.displayName} eliminado'),
        action: SnackBarAction(
          label: 'Deshacer',
          textColor: AppColors.accent,
          onPressed: () {
            setState(() => _activeMeals.insert(index, removed));
          },
        ),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _addMeal(MealTemplate template) {
    setState(() => _activeMeals.add(template));
  }

  void _showAddMealSheet() {
    final available = _availableTemplates;
    if (available.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Todos los tipos de comida ya están agregados'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    MealTemplateSelector.show(
      context,
      templates: available,
      onSelected: _addMeal,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
            children: [
              _topBar(),
              const SizedBox(height: 16),
              _dayStrip(),
              const SizedBox(height: 16),
              _promoBanner(),
              const SizedBox(height: 16),
              _macroCard(),
              const SizedBox(height: 24),
              _mealSection(),
            ],
          ),
          Positioned(
            right: 16,
            bottom: 16,
            child: FloatingActionButton(
              onPressed: _showAddMealSheet,
              backgroundColor: AppColors.accent,
              foregroundColor: AppColors.bg,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.add, size: 28),
            ),
          ),
        ],
      ),
    );
  }

  Widget _topBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.auto_awesome,
                color: AppColors.textSecondary, size: 22),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.water_drop_outlined,
                color: AppColors.textSecondary, size: 22),
            onPressed: () {},
          ),
          const Spacer(),
          const Pill(text: 'Jue 26', type: PillType.info),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.more_horiz,
                color: AppColors.textSecondary, size: 22),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _dayStrip() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _days.asMap().entries.map((e) {
          final i = e.key;
          final d = e.value;
          final selected = i == _selectedDay;
          return GestureDetector(
            onTap: () => setState(() { _selectedDay = i; }),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 44,
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: selected ? AppColors.accent : Colors.transparent,
                border: Border.all(
                  color: selected
                      ? AppColors.accent
                      : AppColors.border.withOpacity(0.3),
                ),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(d.$1,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: selected
                            ? AppColors.bg
                            : AppColors.textSecondary,
                      )),
                  const SizedBox(height: 2),
                  Text(d.$2,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: selected ? AppColors.bg : AppColors.text,
                      )),
                  if (d.$3)
                    Container(
                      width: 4,
                      height: 4,
                      margin: const EdgeInsets.only(top: 2),
                      decoration: const BoxDecoration(
                        color: AppColors.accent,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _promoBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.accent.withOpacity(0.15),
            AppColors.accent.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: AppColors.accent.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.auto_awesome,
              color: AppColors.accent, size: 32),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Ahorra 75% en Premium!',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.accent,
                    )),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.timer_outlined,
                        color: AppColors.textSecondary, size: 14),
                    const SizedBox(width: 4),
                    const Text('24:15:30',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        )),
                  ],
                ),
              ],
            ),
          ),
          Flexible(
            child: AppButton(
              text: 'Obtener',
              type: AppButtonType.primary,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _macroCard() {
    return AppCard(
      child: Column(
        children: [
          Row(
            children: [
              const Text('0 / 2,539 kcal',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.text,
                  )),
              const Spacer(),
              GestureDetector(
                onTap: () {},
                child: const Icon(Icons.edit,
                    color: AppColors.accent, size: 18),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 100,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const Center(
                  child: CurvedGauge(
                    progress: 0,
                    value: '0',
                    label: 'kcal',
                  ),
                ),
                const Positioned(
                  top: 10,
                  left: 30,
                  child: Text('2,285',
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary)),
                ),
                const Positioned(
                  top: 10,
                  right: 30,
                  child: Text('2,793',
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _macroColumn('Proteínas', 0, 146),
              _macroColumn('Carbs', 0, 298),
              _macroColumn('Grasas', 0, 85),
            ],
          ),
          const SizedBox(height: 16),
          AppButton(
            text: 'Terminar Día',
            type: AppButtonType.secondary,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _macroColumn(String label, int current, int total) {
    return Expanded(
      child: Column(
        children: [
          Text('$total',
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textSecondary)),
          const SizedBox(height: 2),
          Text(label,
              style: const TextStyle(
                  fontSize: 11, color: AppColors.textSecondary)),
          const SizedBox(height: 2),
          Text('$current / $total g',
              style: const TextStyle(
                  fontSize: 11, color: AppColors.textTertiary)),
        ],
      ),
    );
  }

  Widget _mealSection() {
    if (_activeMeals.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(text: 'Comidas'),
          AppCard(
            child: GestureDetector(
              onTap: _showAddMealSheet,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Column(
                    children: [
                      Icon(Icons.add_circle_outline,
                          color: AppColors.accent.withOpacity(0.5), size: 36),
                      const SizedBox(height: 8),
                      const Text(
                        'Agregar comida',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(text: 'Comidas'),
        ..._activeMeals.map((meal) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: MealCard(
              template: meal,
              onDeleted: () => _removeMeal(_activeMeals.indexOf(meal)),
            ),
          );
        }),
        const SizedBox(height: 4),
        Center(
          child: GestureDetector(
            onTap: _showAddMealSheet,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add_circle_outline,
                    color: AppColors.accent, size: 18),
                const SizedBox(width: 4),
                Text(
                  'Agregar comida',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.accent,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
