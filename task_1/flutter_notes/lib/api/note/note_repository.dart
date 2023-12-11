import 'package:flutter_notes/api/note/data_provider.dart';
import 'package:flutter_notes/domain/note/note.dart';

/// Interface of note's repositories.
abstract interface class INoteRepository {
  /// Returns all saved notes.
  Future<List<Note>> getNotes();

  /// Saves new note in storage.
  void addNote(Note note);
}

/// Note repository.
class NoteRepository implements INoteRepository {
  /// Source of notes.
  final INoteDataProvider dataProvider;

  /// @nodoc
  NoteRepository({required this.dataProvider});

  @override
  Future<List<Note>> getNotes() async {
    return dataProvider.getNotes();
  }

  @override
  void addNote(Note note) {
    dataProvider.addNote(note);
  }
}
