import 'package:flutter_notes/api/note/data_provider.dart';
import 'package:flutter_notes/api/note/dto/note.dart';
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
    final res = await dataProvider.getNotes();
    return res
        .map(
          (e) => Note(
            title: e.title,
            description: e.description,
            date: e.date,
          ),
        )
        .toList();
  }

  @override
  void addNote(Note note) {
    dataProvider.addNote(
      NoteDto(
        title: note.title,
        description: note.description,
        date: note.date,
      ),
    );
  }
}
