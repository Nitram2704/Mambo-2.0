import 'package:flutter/material.dart' hide Chip;
import 'package:vitalis_app/core/widgets/common_widgets.dart';
import 'package:vitalis_app/core/theme/app_theme.dart';
import '../../domain/entities/food_item.dart';

class NutritionSearchPage extends StatefulWidget {
  final List<FoodItem> foods;
  final void Function(String) onNavigate;
  final VoidCallback onGoBack;
  const NutritionSearchPage({
    super.key,
    required this.foods,
    required this.onNavigate,
    required this.onGoBack,
  });
  @override
  State<NutritionSearchPage> createState() => _NutritionSearchPageState();
}

class _NutritionSearchPageState extends State<NutritionSearchPage> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.text),
          onPressed: widget.onGoBack,
        ),
        title: const Text('Buscar'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Buscar alimentos...',
                prefixIcon: Icon(
                  Icons.search,
                  color: AppColors.textSecondary,
                  size: 20,
                ),
              ),
              style: const TextStyle(color: AppColors.text, fontSize: 15),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: widget.foods.length,
              separatorBuilder: (_, __) => const SizedBox(height: 4),
              itemBuilder: (_, i) {
                final food = widget.foods[i];
                return ListItem(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.accent.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.restaurant_outlined,
                        color: AppColors.accent, size: 20),
                  ),
                  title: food.name,
                  trailing: '${food.kcal} kcal',
                  onTap: () => widget.onNavigate('seleccionar'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
