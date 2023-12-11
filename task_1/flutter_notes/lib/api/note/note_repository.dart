import 'package:flutter_notes/api/note/data_provider.dart';
import 'package:flutter_notes/domain/note/note.dart';

/// Interface of note's repositories.
abstract interface class INoteRepository {
  /// Returns all saved notes.
  Future<List<Note>> getNotes();
}

/// Note repository.
class MockNoteRepository implements INoteRepository {
  /// Source of notes.
  final INoteDataProvider dataProvider;

  /// @nodoc
  MockNoteRepository({required this.dataProvider});

  @override
  Future<List<Note>> getNotes() {
    return dataProvider.getNotes();
  }
}
