class FoodItem {
  final String id;
  final String name;
  final String? emoji;
  final int kcal;
  final double protein;
  final double carbs;
  final double fat;
  final String? portion;

  const FoodItem({
    required this.id,
    required this.name,
    this.emoji,
    required this.kcal,
    required this.protein,
    required this.carbs,
    required this.fat,
    this.portion,
  });
}
