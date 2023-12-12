import 'package:hive/hive.dart';

part 'note.g.dart';

/// Note list model.
@HiveType(typeId: 1)
class NoteDtoList {
  /// @nodoc
  NoteDtoList({required this.notes});

  /// Notes.
  @HiveField(0)
  List<NoteDto> notes;
}

/// Note model.
@HiveType(typeId: 0)
class NoteDto {
  /// @nodoc
  NoteDto({required this.title, required this.description, required this.date});

  /// Title.
  @HiveField(0)
  final String title;

  /// Body of note.
  @HiveField(1)
  final String description;

  /// Date of last modification.
  @HiveField(2)
  final DateTime date;
}
