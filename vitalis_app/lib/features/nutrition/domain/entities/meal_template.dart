import 'package:flutter/material.dart';
import 'meal_entry.dart';
import 'meal_type.dart';

class MealItem {
  final String name;
  final double kcal;
  const MealItem(this.name, this.kcal);
}

class MealTemplate {
  final MealType type;
  final List<MealEntry> entries;

  const MealTemplate({
    required this.type,
    this.entries = const [],
  });

  IconData get icon => type.icon;
  String get time => type.time;
  String get displayName => type.displayName;

  int get totalKcal => entries.fold(0, (sum, e) => sum + e.kcal);
  double get totalProtein => entries.fold(0.0, (sum, e) => sum + e.protein);
  double get totalCarbs => entries.fold(0.0, (sum, e) => sum + e.carbs);
  double get totalFat => entries.fold(0.0, (sum, e) => sum + e.fat);
  bool get isEmpty => entries.isEmpty;

  List<MealItem> get items =>
      entries.map((e) => MealItem(e.food.name, e.kcal.toDouble())).toList();

  MealTemplate addEntry(MealEntry entry) {
    return MealTemplate(type: type, entries: [...entries, entry]);
  }

  MealTemplate removeEntry(int index) {
    final newList = List<MealEntry>.from(entries)..removeAt(index);
    return MealTemplate(type: type, entries: newList);
  }

  static List<MealTemplate> defaults() {
    return MealType.values
        .map((t) => MealTemplate(type: t))
        .toList();
  }
}
