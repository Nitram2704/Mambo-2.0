import 'package:flutter/material.dart';
import '../domain/entities/user.dart';
import '../domain/entities/activity.dart';
import '../domain/repositories/home_repository.dart';

class MockHomeRepository implements HomeRepository {
  @override
  User getUser() {
    return const User(
      name: 'Valentina R.',
      email: 'vale.fit@email.com',
      username: '@vale.fit',
      peso: 63,
      altura: 1.68,
      memberSince: 'junio 2025',
      plan: 'Tonificación',
      entrenos: 143,
      completitud: 87,
      isAdult: true,
    );
  }

  @override
  List<Activity> getRecentActivities() {
    return const [
      Activity(title: 'Cardio matinal', value: '45 min', time: 'Hace 2h', icon: Icons.favorite_border),
      Activity(title: 'Estiramientos', value: '20 min', time: 'Hace 5h', icon: Icons.accessibility_new),
      Activity(title: 'Registro de comidas', value: 'Completo', time: 'Hace 1h', icon: Icons.restaurant),
    ];
  }
}
