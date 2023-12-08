import 'package:flutter_notes/domain/note/note.dart';

/// Interface for note data providers.
abstract interface class INoteDataProvider {
  /// Return list of notes from storage.
  List<Note> getNotes();
}

/// Data provider for notes data.
class MockNoteDataProvider implements INoteDataProvider {
  @override
  List<Note> getNotes() {
    return List.generate(
      3,
      (index) => Note(
        title: 'Список покупок $index',
        description: '* Яйца\n* Хлеб\n* Молоко',
        date: DateTime(2023, 11, index + 1),
      ),
    );
  }
}
