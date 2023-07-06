// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notemodule.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NodeModuleAdapter extends TypeAdapter<NoteModule> {
  @override
  final int typeId = 0;

  @override
  NoteModule read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoteModule(
      title: fields[1] as String,
      content: fields[2] as String,
      date: fields[3] as DateTime,
      color: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, NoteModule obj) {
    writer
      ..writeByte(4)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.content)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.color);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NodeModuleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
