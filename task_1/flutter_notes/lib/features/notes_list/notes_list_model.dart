import 'package:elementary/elementary.dart';
import 'package:flutter_notes/api/note/note_repository.dart';
import 'package:flutter_notes/domain/note/note.dart';

/// Model for notel list screen.
class NotesListScreenModel extends ElementaryModel {
  /// Repository for access to notes.
  final INoteRepository noteRepository;

  /// @nodoc
  NotesListScreenModel(this.noteRepository);

  /// Loads notes for widget model.
  Future<List<Note>> loadNotes() async {
    return noteRepository.getNotes();
  }
}
