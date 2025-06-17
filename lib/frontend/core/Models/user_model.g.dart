// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 11;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      email: fields[0] as String,
      password: fields[1] as String,
      age: fields[2] as String,
      gender: fields[3] as String,
      height: fields[4] as int,
      weight: fields[5] as int,
      lifestyle: fields[6] as String,
      bmi: fields[7] as int,
      tdee: fields[8] as int,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.email)
      ..writeByte(1)
      ..write(obj.password)
      ..writeByte(2)
      ..write(obj.age)
      ..writeByte(3)
      ..write(obj.gender)
      ..writeByte(4)
      ..write(obj.height)
      ..writeByte(5)
      ..write(obj.weight)
      ..writeByte(6)
      ..write(obj.lifestyle)
      ..writeByte(7)
      ..write(obj.bmi)
      ..writeByte(8)
      ..write(obj.tdee);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
