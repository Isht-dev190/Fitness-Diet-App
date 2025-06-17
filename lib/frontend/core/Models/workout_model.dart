import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'workout_model.g.dart';

@HiveType(typeId: 2)
class WorkoutExercise {
  @HiveField(0)
  final String exerciseName;

  @HiveField(1)
  final int? sets;

  @HiveField(2)
  final int? reps;

  @HiveField(3)
  final int? duration;

  WorkoutExercise({
    required this.exerciseName,
    this.sets,
    this.reps,
    this.duration,
  }) : assert(
          (sets != null && reps != null) || duration != null,
          'Either sets and reps or duration must be provided',
        );

  WorkoutExercise copyWith({
    String? exerciseName,
    int? sets,
    int? reps,
    int? duration,
  }) {
    return WorkoutExercise(
      exerciseName: exerciseName ?? this.exerciseName,
      sets: sets ?? this.sets,
      reps: reps ?? this.reps,
      duration: duration ?? this.duration,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'exerciseName': exerciseName,
      'sets': sets,
      'reps': reps,
      'duration': duration,
    };
  }

  factory WorkoutExercise.fromJson(Map<String, dynamic> json) {
    return WorkoutExercise(
      exerciseName: json['exerciseName'] as String,
      sets: json['sets'] as int?,
      reps: json['reps'] as int?,
      duration: json['duration'] as int?,
    );
  }
}

@HiveType(typeId: 3)
class Workout {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final List<WorkoutExercise> exercises;

  @HiveField(3)
  final List<DateTime> scheduledDates;

  @HiveField(4)
  final int hour;

  @HiveField(5)
  final int minute;

  @HiveField(6)
  final bool notificationsEnabled;

  @HiveField(7)
  final String userEmail;

  TimeOfDay get time => TimeOfDay(hour: hour, minute: minute);

  Workout({
    required this.id,
    required this.name,
    required this.exercises,
    required this.scheduledDates,
    required this.hour,
    required this.minute,
    required this.userEmail,
    this.notificationsEnabled = false,
  });

  factory Workout.fromTimeOfDay({
    required String id,
    required String name,
    required List<WorkoutExercise> exercises,
    required List<DateTime> scheduledDates,
    required TimeOfDay time,
    required String userEmail,
    bool notificationsEnabled = false,
  }) {
    return Workout(
      id: id,
      name: name,
      exercises: exercises,
      scheduledDates: scheduledDates,
      hour: time.hour,
      minute: time.minute,
      userEmail: userEmail,
      notificationsEnabled: notificationsEnabled,
    );
  }

  Workout copyWith({
    String? id,
    String? name,
    List<WorkoutExercise>? exercises,
    List<DateTime>? scheduledDates,
    TimeOfDay? time,
    String? userEmail,
    bool? notificationsEnabled,
  }) {
    return Workout(
      id: id ?? this.id,
      name: name ?? this.name,
      exercises: exercises ?? this.exercises,
      scheduledDates: scheduledDates ?? this.scheduledDates,
      hour: time?.hour ?? this.hour,
      minute: time?.minute ?? this.minute,
      userEmail: userEmail ?? this.userEmail,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'exercises': exercises.map((e) => e.toJson()).toList(),
      'scheduledDates': scheduledDates.map((e) => e.toIso8601String()).toList(),
      'hour': hour,
      'minute': minute,
      'userEmail': userEmail,
      'notificationsEnabled': notificationsEnabled,
    };
  }

  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      id: json['id'] as String,
      name: json['name'] as String,
      exercises: (json['exercises'] as List)
          .map((e) => WorkoutExercise.fromJson(e as Map<String, dynamic>))
          .toList(),
      scheduledDates: (json['scheduledDates'] as List)
          .map((e) => DateTime.parse(e as String))
          .toList(),
      hour: json['hour'] as int,
      minute: json['minute'] as int,
      userEmail: json['userEmail'] as String,
      notificationsEnabled: json['notificationsEnabled'] as bool,
    );
  }
}

