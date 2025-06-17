import 'package:app_dev_fitness_diet/frontend/core/Dependencies/initDependencies.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/exercise_model.dart';
import 'package:app_dev_fitness_diet/frontend/core/storage/base_storage_service.dart';
import 'package:hive/hive.dart';

class ExerciseStorageService extends BaseStorageService<Exercise> {
  static final ExerciseStorageService _instance = ExerciseStorageService._internal();
  
  factory ExerciseStorageService() {
    return _instance;
  }
  
  ExerciseStorageService._internal() : super(HiveInitializer.exerciseBoxName);

  Future<void> saveExercise(Exercise exercise) async {
    await add(exercise.name, exercise);
  }

  Future<void> updateExercise(Exercise exercise) async {
    await update(exercise.name, exercise);
  }

  Exercise? getExercise(String name) {
    return get(name);
  }

  List<Exercise> getExercisesByCategory(String category) {
    return getAll().where((exercise) => exercise.category == category).toList();
  }

  Future<void> deleteExercise(String name) async {
    await delete(name);
  }

  List<Exercise> getAllExercises() {
    return getAll();
  }

  bool exerciseExists(String name) {
    return exists(name);
  }

  Stream<BoxEvent> watchExercises() {
    return watch();
  }

  Future<void> saveAllExercises(List<Exercise> exercises) async {
    final exerciseMap = {for (var exercise in exercises) exercise.name: exercise};
    await addAll(exerciseMap);
  }
} 