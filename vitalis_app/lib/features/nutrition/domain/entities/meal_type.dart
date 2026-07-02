import 'package:flutter/material.dart';

enum MealType {
  breakfast('Desayuno', Icons.wb_sunny_outlined, '7:00 - 9:00'),
  midMorning('Media Mañana', Icons.coffee_outlined, '10:00 - 11:00'),
  lunch('Almuerzo', Icons.lunch_dining_outlined, '12:00 - 14:00'),
  dinner('Cena', Icons.nightlight_outlined, '19:00 - 21:00');

  final String label;
  final IconData icon;
  final String time;
  const MealType(this.label, this.icon, this.time);

  String get displayName => label;
}
