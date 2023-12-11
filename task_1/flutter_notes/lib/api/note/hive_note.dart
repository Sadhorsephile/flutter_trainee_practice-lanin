import 'package:flutter_notes/domain/note/note.dart';
import 'package:hive/hive.dart';

part 'hive_note.g.dart';

/// Note list model.
@HiveType(typeId: 1)
class NoteList {
  /// @nodoc
  NoteList({required this.notes});

  /// Notes.
  @HiveField(0)
  List<Note> notes;
}
