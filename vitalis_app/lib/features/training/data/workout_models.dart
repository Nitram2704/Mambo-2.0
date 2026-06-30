/// Models for the active workout session (mock data).

class WorkoutSet {
  double weight;
  int reps;
  bool completed;

  WorkoutSet({
    required this.weight,
    required this.reps,
    this.completed = false,
  });
}

class ActiveExercise {
  final String name;
  String note;
  final List<WorkoutSet> sets;

  ActiveExercise({
    required this.name,
    this.note = '',
    required this.sets,
  });

  int get completedSets => sets.where((s) => s.completed).length;
}

/// Mock routine data for "Push intensivo"
List<ActiveExercise> createMockRoutine() {
  return [
    ActiveExercise(
      name: 'Press banca',
      sets: [
        WorkoutSet(weight: 60, reps: 10),
        WorkoutSet(weight: 60, reps: 10),
        WorkoutSet(weight: 65, reps: 8),
        WorkoutSet(weight: 65, reps: 8),
      ],
    ),
    ActiveExercise(
      name: 'Press inclinado',
      sets: [
        WorkoutSet(weight: 40, reps: 12),
        WorkoutSet(weight: 40, reps: 12),
        WorkoutSet(weight: 45, reps: 10),
      ],
    ),
    ActiveExercise(
      name: 'Aperturas con mancuernas',
      sets: [
        WorkoutSet(weight: 14, reps: 15),
        WorkoutSet(weight: 14, reps: 15),
        WorkoutSet(weight: 16, reps: 12),
      ],
    ),
    ActiveExercise(
      name: 'Press militar',
      sets: [
        WorkoutSet(weight: 30, reps: 10),
        WorkoutSet(weight: 30, reps: 10),
        WorkoutSet(weight: 35, reps: 8),
      ],
    ),
    ActiveExercise(
      name: 'Elevaciones laterales',
      sets: [
        WorkoutSet(weight: 10, reps: 15),
        WorkoutSet(weight: 10, reps: 15),
        WorkoutSet(weight: 12, reps: 12),
      ],
    ),
    ActiveExercise(
      name: 'Extensiones de tríceps',
      sets: [
        WorkoutSet(weight: 20, reps: 12),
        WorkoutSet(weight: 20, reps: 12),
        WorkoutSet(weight: 25, reps: 10),
      ],
    ),
    ActiveExercise(
      name: 'Fondos en paralelas',
      sets: [
        WorkoutSet(weight: 0, reps: 12),
        WorkoutSet(weight: 0, reps: 12),
        WorkoutSet(weight: 0, reps: 10),
      ],
    ),
    ActiveExercise(
      name: 'Press francés',
      sets: [
        WorkoutSet(weight: 15, reps: 12),
        WorkoutSet(weight: 15, reps: 12),
        WorkoutSet(weight: 18, reps: 10),
      ],
    ),
  ];
}
