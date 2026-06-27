import '../entities/exercise.dart';
import '../entities/routine.dart';

abstract class TrainingRepository {
  Future<List<Exercise>> getExercises();
  Future<List<Routine>> getRoutines();
  Future<List<Routine>> getPopularRoutines();
}
