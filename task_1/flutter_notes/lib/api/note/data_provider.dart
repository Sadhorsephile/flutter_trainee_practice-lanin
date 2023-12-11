//import 'package:flutter_notes/api/note/hive_note.dart';
import 'package:flutter_notes/domain/note/note.dart';
import 'package:hive/hive.dart';

/// Interface for note data providers.
abstract interface class INoteDataProvider {
  /// Return list of notes from storage.
  Future<List<Note>> getNotes();

  /// Saves new note in storage.
  void addNote(Note newNote);
}

/// Provider for notes that uses hive persist storage.
class NoteDataProvider implements INoteDataProvider {
  /// Hive box for notes.
  //final Box<NoteList> notesBox;
  final Box<List<Note>> notesBox;

  /// @nodoc
  const NoteDataProvider({required this.notesBox});

  @override
  Future<List<Note>> getNotes() async {
    // final res = notesBox.get('notes');
    // if (res != null) {
    //   return res.notes;
    // }
    // return List<Note>.empty();
    final res = notesBox.get('notes');
    if (res != null) {
      return res;
    }
    return List<Note>.empty();
  }

  @override
  void addNote(Note newNote) {
    // final notes = notesBox.get('notes');
    // if (notes == null) {
    //   notesBox.put('notes', NoteList(notes: <Note>[newNote]));
    // } else {
    //   notes.notes.add(newNote);
    //   notesBox.put('notes', notes);
    // }
    final notes = notesBox.get('notes');
    if (notes == null) {
      notesBox.put('notes', <Note>[newNote]);
    } else {
      notes.add(newNote);
      notesBox.put('notes', notes);
    }
  }
}

/// Data provider for notes data.
class MockNoteDataProvider implements INoteDataProvider {
  @override
  Future<List<Note>> getNotes() async {
    return List.generate(
      3,
      (index) => Note(
        title: 'Список покупок $index',
        description: '* Яйца\n* Хлеб\n* Молоко',
        date: DateTime(2023, 11, index + 1),
      ),
    );
  }

  @override
  void addNote(Note newNote) {
    return;
  }
}
