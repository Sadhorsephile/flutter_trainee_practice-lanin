import 'package:flutter_notes/api/note/dto/note.dart';
import 'package:hive/hive.dart';
import 'package:surf_logger/surf_logger.dart';

/// Interface for note data providers.
abstract interface class INoteDataProvider {
  /// Return list of notes from storage.
  Future<List<NoteDto>> getNotes();

  /// Saves new note in storage.
  void addNote(NoteDto newNote);
}

/// Provider for notes that uses hive persist storage.
class NoteDataProvider implements INoteDataProvider {
  /// Hive box for notes.
  final Box<NoteDtoList> notesBox;

  /// @nodoc
  const NoteDataProvider({required this.notesBox});

  /// Name for note's hive box.
  static const hiveNotesBoxName = 'notes_box';

  static const _hiveNotesKey = 'notes_key';

  /// Init box and adapters for notes.
  static Future<void> init() async {
    Hive
      ..registerAdapter<NoteDto>(NoteDtoAdapter())
      ..registerAdapter<NoteDtoList>(NoteDtoListAdapter());
    await Hive.openBox<NoteDtoList>(hiveNotesBoxName);
  }

  @override
  Future<List<NoteDto>> getNotes() async {
    final res = notesBox.get(_hiveNotesKey);
    if (res != null) {
      try {
        final recoveredNotes = res.notes;
        return recoveredNotes;
      } on Exception catch (e) {
        Logger.d(e.toString());
      }
    }
    return List<NoteDto>.empty();
  }

  @override
  void addNote(NoteDto newNote) {
    final notes = notesBox.get(_hiveNotesKey);
    if (notes == null) {
      notesBox.put(_hiveNotesKey, NoteDtoList(notes: [newNote]));
    } else {
      notes.notes.add(newNote);
      notesBox.put(_hiveNotesKey, notes);
    }
  }
}

/// Data provider for notes data.
class MockNoteDataProvider implements INoteDataProvider {
  final _notes = List.generate(
    3,
    (index) => NoteDto(
      title: 'Список покупок $index',
      description: '* Яйца\n* Хлеб\n* Молоко',
      date: DateTime(2023, 11, index + 1),
    ),
  );

  @override
  Future<List<NoteDto>> getNotes() async {
    return _notes;
  }

  @override
  void addNote(NoteDto newNote) {
    _notes.add(newNote);
  }
}
