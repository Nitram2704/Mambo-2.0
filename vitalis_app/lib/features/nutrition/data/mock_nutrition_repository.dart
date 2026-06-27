import '../domain/entities/food_item.dart';
import '../domain/repositories/nutrition_repository.dart';

class MockNutritionRepository implements NutritionRepository {
  @override
  List<FoodItem> getFoods() {
    return const [
      FoodItem(name: 'Pollo pechuga', kcal: 165, protein: 31, carbs: 0, fat: 3.6),
      FoodItem(name: 'Arroz blanco', kcal: 130, protein: 2.7, carbs: 28, fat: 0.3),
      FoodItem(name: 'Huevo', kcal: 155, protein: 13, carbs: 1.1, fat: 11),
      FoodItem(name: 'Aguacate', kcal: 160, protein: 2, carbs: 9, fat: 15),
      FoodItem(name: 'Batido proteína', kcal: 120, protein: 24, carbs: 3, fat: 1.5),
    ];
  }

  @override
  List<NutritionHistoryEntry> getHistory() {
    return const [
      NutritionHistoryEntry(label: 'Hoy', kcal: 1842, pillType: 'success', macros: [
        ('Proteínas', 92),
        ('Carbohidratos', 210),
        ('Grasas', 65),
      ]),
      NutritionHistoryEntry(label: 'Ayer', kcal: 2560, pillType: 'warning', macros: [
        ('Proteínas', 78),
        ('Carbohidratos', 320),
        ('Grasas', 95),
      ]),
      NutritionHistoryEntry(label: 'Lun', kcal: 2180, pillType: 'success', macros: [
        ('Proteínas', 105),
        ('Carbohidratos', 240),
        ('Grasas', 72),
      ]),
    ];
  }
}
