// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fasting_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FastingAdapter extends TypeAdapter<Fasting> {
  @override
  final int typeId = 5;

  @override
  Fasting read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Fasting(
      id: fields[0] as String,
      startTime: fields[1] as DateTime,
      endTime: fields[2] as DateTime,
      durationMinutes: fields[3] as int,
      isCompleted: fields[4] as bool,
      userEmail: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Fasting obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.startTime)
      ..writeByte(2)
      ..write(obj.endTime)
      ..writeByte(3)
      ..write(obj.durationMinutes)
      ..writeByte(4)
      ..write(obj.isCompleted)
      ..writeByte(5)
      ..write(obj.userEmail);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FastingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
