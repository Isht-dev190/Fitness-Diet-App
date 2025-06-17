// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MealFoodAdapter extends TypeAdapter<MealFood> {
  @override
  final int typeId = 7;

  @override
  MealFood read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MealFood(
      food: fields[0] as Food,
      portionSize: fields[1] as double,
      calories: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, MealFood obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.food)
      ..writeByte(1)
      ..write(obj.portionSize)
      ..writeByte(2)
      ..write(obj.calories);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MealFoodAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MealAdapter extends TypeAdapter<Meal> {
  @override
  final int typeId = 8;

  @override
  Meal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Meal(
      id: fields[0] as String,
      name: fields[1] as String,
      foods: (fields[2] as List).cast<MealFood>(),
      userEmail: fields[4] as String,
      createdAt: fields[3] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, Meal obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.foods)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.userEmail);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MealAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
