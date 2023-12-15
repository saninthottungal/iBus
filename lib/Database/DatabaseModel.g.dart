// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DatabaseModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BusModelAdapter extends TypeAdapter<BusModel> {
  @override
  final int typeId = 1;

  @override
  BusModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BusModel(
      id: fields[0] as String,
      name: fields[1] as String,
      number: fields[2] as String,
      time: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, BusModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.number)
      ..writeByte(3)
      ..write(obj.time);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BusModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
