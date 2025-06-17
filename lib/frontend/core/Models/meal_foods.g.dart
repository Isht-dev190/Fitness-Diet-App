// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_foods.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MealFoodsAdapter extends TypeAdapter<MealFoods> {
  @override
  final int typeId = 9;

  @override
  MealFoods read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MealFoods(
      foodName: fields[0] as String,
      portionAmount: fields[1] as String,
      portionUnit: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MealFoods obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.foodName)
      ..writeByte(1)
      ..write(obj.portionAmount)
      ..writeByte(2)
      ..write(obj.portionUnit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MealFoodsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
