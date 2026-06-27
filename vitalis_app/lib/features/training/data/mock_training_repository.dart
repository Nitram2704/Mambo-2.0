import '../domain/entities/exercise.dart';
import '../domain/entities/routine.dart';
import '../domain/repositories/training_repository.dart';

class MockTrainingRepository implements TrainingRepository {
  @override
  Future<List<Exercise>> getExercises() async {
    return const [
      Exercise(name: 'Aperturas', equipment: 'Máquina'),
      Exercise(name: 'Press de Banca Inclinado', equipment: 'Mancuerna'),
      Exercise(name: 'Press de Banca en Declive', equipment: 'Máquina'),
      Exercise(name: 'Press de Hombros', equipment: 'Máquina de Discos'),
      Exercise(name: 'Elevación Laterales', equipment: 'Mancuerna'),
      Exercise(name: 'Extensión de Tríceps', equipment: 'Cable'),
      Exercise(name: 'Tríceps con Polea', equipment: ''),
      Exercise(name: 'Aducción de Caderas', equipment: ''),
    ];
  }

  @override
  Future<List<Routine>> getRoutines() async {
    return const [
      Routine(
        name: 'Espalda',
        exercises: [
          Exercise(name: 'Pull Over', equipment: ''),
          Exercise(name: 'Jalón al Pecho', equipment: ''),
          Exercise(name: 'Remo Sentado', equipment: ''),
          Exercise(name: 'Vuelos Posteriores', equipment: ''),
        ],
      ),
      Routine(
        name: 'Pierna',
        exercises: [
          Exercise(name: 'Aducción de Caderas', equipment: ''),
          Exercise(name: 'Extensión de Pantorrilla', equipment: ''),
          Exercise(name: 'Curl de Pierna', equipment: ''),
          Exercise(name: 'Sentadilla', equipment: ''),
        ],
      ),
      Routine(
        name: 'Pecho',
        exercises: [
          Exercise(name: 'Aperturas', equipment: ''),
          Exercise(name: 'Press de Banca Inclinado', equipment: ''),
          Exercise(name: 'Press de Banca en Declive', equipment: ''),
        ],
      ),
    ];
  }

  @override
  Future<List<Routine>> getPopularRoutines() async {
    return const [
      Routine(
        name: 'Full Body Principiante',
        exercises: [
          Exercise(name: 'Sentadilla', equipment: ''),
          Exercise(name: 'Press de Banca', equipment: ''),
          Exercise(name: 'Remo con Barra', equipment: ''),
        ],
      ),
      Routine(
        name: 'Push Pull Legs',
        exercises: [
          Exercise(name: 'Press de Banca', equipment: ''),
          Exercise(name: 'Press de Hombros', equipment: ''),
          Exercise(name: 'Aperturas', equipment: ''),
          Exercise(name: 'Jalón al Pecho', equipment: ''),
          Exercise(name: 'Remo con Barra', equipment: ''),
          Exercise(name: 'Curl de Bíceps', equipment: ''),
          Exercise(name: 'Sentadilla', equipment: ''),
          Exercise(name: 'Prensa de Piernas', equipment: ''),
          Exercise(name: 'Curl de Pierna', equipment: ''),
        ],
      ),
      Routine(
        name: 'Core 10 minutos',
        exercises: [
          Exercise(name: 'Plancha', equipment: ''),
          Exercise(name: 'Crunch', equipment: ''),
          Exercise(name: 'Russian Twist', equipment: ''),
          Exercise(name: 'Mountain Climbers', equipment: ''),
          Exercise(name: 'Leg Raise', equipment: ''),
        ],
      ),
    ];
  }
}
