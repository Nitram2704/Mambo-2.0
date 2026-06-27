import '../entities/food_item.dart';

abstract class NutritionRepository {
  List<FoodItem> getFoods();
  List<NutritionHistoryEntry> getHistory();
}

class NutritionHistoryEntry {
  final String label;
  final int kcal;
  final String pillType;
  final List<(String, int)> macros;

  const NutritionHistoryEntry({
    required this.label,
    required this.kcal,
    required this.pillType,
    required this.macros,
  });
}
