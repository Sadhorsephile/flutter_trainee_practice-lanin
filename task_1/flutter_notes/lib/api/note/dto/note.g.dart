// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: public_member_api_docs

part of 'note.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteDtoListAdapter extends TypeAdapter<NoteDtoList> {
  @override
  final int typeId = 1;

  @override
  NoteDtoList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoteDtoList(
      notes: (fields[0] as List).cast<NoteDto>(),
    );
  }

  @override
  void write(BinaryWriter writer, NoteDtoList obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteDtoListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class NoteDtoAdapter extends TypeAdapter<NoteDto> {
  @override
  final int typeId = 0;

  @override
  NoteDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoteDto(
      title: fields[0] as String,
      description: fields[1] as String,
      date: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, NoteDto obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
