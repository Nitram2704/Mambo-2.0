import 'food_item.dart';

class MealEntry {
  final FoodItem food;
  final double servings;

  const MealEntry({
    required this.food,
    this.servings = 1.0,
  });

  int get kcal => (food.kcal * servings).round();
  double get protein => food.protein * servings;
  double get carbs => food.carbs * servings;
  double get fat => food.fat * servings;

  MealEntry copyWith({FoodItem? food, double? servings}) {
    return MealEntry(
      food: food ?? this.food,
      servings: servings ?? this.servings,
    );
  }
}
