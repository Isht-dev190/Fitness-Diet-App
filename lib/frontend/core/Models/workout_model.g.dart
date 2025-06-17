// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WorkoutExerciseAdapter extends TypeAdapter<WorkoutExercise> {
  @override
  final int typeId = 2;

  @override
  WorkoutExercise read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkoutExercise(
      exerciseName: fields[0] as String,
      sets: fields[1] as int?,
      reps: fields[2] as int?,
      duration: fields[3] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, WorkoutExercise obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.exerciseName)
      ..writeByte(1)
      ..write(obj.sets)
      ..writeByte(2)
      ..write(obj.reps)
      ..writeByte(3)
      ..write(obj.duration);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkoutExerciseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WorkoutAdapter extends TypeAdapter<Workout> {
  @override
  final int typeId = 3;

  @override
  Workout read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Workout(
      id: fields[0] as String,
      name: fields[1] as String,
      exercises: (fields[2] as List).cast<WorkoutExercise>(),
      scheduledDates: (fields[3] as List).cast<DateTime>(),
      hour: fields[4] as int,
      minute: fields[5] as int,
      userEmail: fields[7] as String,
      notificationsEnabled: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Workout obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.exercises)
      ..writeByte(3)
      ..write(obj.scheduledDates)
      ..writeByte(4)
      ..write(obj.hour)
      ..writeByte(5)
      ..write(obj.minute)
      ..writeByte(6)
      ..write(obj.notificationsEnabled)
      ..writeByte(7)
      ..write(obj.userEmail);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkoutAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
