import 'package:app_dev_fitness_diet/frontend/core/Dependencies/initDependencies.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/workout_model.dart';
import 'package:app_dev_fitness_diet/frontend/core/storage/base_storage_service.dart';
import 'package:hive/hive.dart';

class WorkoutStorageService extends BaseStorageService<Workout> {
  static final WorkoutStorageService _instance = WorkoutStorageService._internal();
  
  factory WorkoutStorageService() {
    return _instance;
  }
  
  WorkoutStorageService._internal() : super(HiveInitializer.workoutBoxName);

  Future<void> saveWorkout(Workout workout) async {
    await add(workout.id, workout);
  }

  Future<void> updateWorkout(Workout workout) async {
    await update(workout.id, workout);
  }

  Workout? getWorkout(String id) {
    return get(id);
  }

  List<Workout> getUserWorkouts(String userEmail) {
    return getAll().where((workout) => workout.userEmail == userEmail).toList();
  }

  Future<void> deleteWorkout(String id) async {
    await delete(id);
  }

  Future<void> deleteUserWorkouts(String userEmail) async {
    final userWorkouts = getUserWorkouts(userEmail);
    for (final workout in userWorkouts) {
      await delete(workout.id);
    }
  }

  List<Workout> getAllWorkouts() {
    return getAll();
  }

  bool workoutExists(String id) {
    return exists(id);
  }

  Stream<BoxEvent> watchUserWorkouts(String userEmail) {
    return watch();
  }

  List<Workout> getScheduledWorkouts(DateTime date, String userEmail) {
    return getUserWorkouts(userEmail).where((workout) => 
      workout.scheduledDates.any((scheduledDate) => 
        scheduledDate.year == date.year &&
        scheduledDate.month == date.month &&
        scheduledDate.day == date.day
      )
    ).toList();
  }
} 