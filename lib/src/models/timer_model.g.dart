// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TimerModelAdapter extends TypeAdapter<TimerModel> {
  @override
  final int typeId = 1;

  @override
  TimerModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TimerModel(
      name: fields[0] as String,
      durationInMilliseconds: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TimerModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.durationInMilliseconds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimerModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
