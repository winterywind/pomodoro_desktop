// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveTrackAdapter extends TypeAdapter<HiveTrack> {
  @override
  final int typeId = 1;

  @override
  HiveTrack read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveTrack(
      id: fields[0] as String,
      timestamp: fields[1] as DateTime,
      length: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, HiveTrack obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.timestamp)
      ..writeByte(2)
      ..write(obj.length);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveTrackAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
