import 'package:collection/collection.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notes/api/note/data_provider.dart';
import 'package:flutter_notes/api/note/note_repository.dart';
import 'package:flutter_notes/domain/note/note.dart';
import 'package:flutter_notes/features/add_note/add_note_widget.dart';
import 'package:flutter_notes/features/notes_list/notes_list.dart';
import 'package:flutter_notes/features/notes_list/notes_list_model.dart';
import 'package:flutter_notes/util/app_dictionary.dart';
import 'package:surf_logger/surf_logger.dart';

/// Widget model class for [NotesListScreen]
class NotesListScreenWidgetModel
    extends WidgetModel<NotesListScreen, NotesListScreenModel>
    implements INotesListWidgetModel {
  /// @nodoc
  NotesListScreenWidgetModel(super._model);

  final _notesListState =
      EntityStateNotifier<Map<DateTime, (GlobalKey, List<Note>)>>();

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _loadNotes();
  }

  @override
  Future<void> goToDay() async {
    final selectedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2023, 10),
      lastDate: DateTime.now(),
    );
    if (selectedDate != null) {
      final maybeData = _notesListState.value.data;
      if (maybeData != null) {
        final dateKey = selectedDate;
        if (maybeData.containsKey(dateKey)) {
          final globalKey = maybeData[dateKey]!.$1;
          _scrollToKey(globalKey);
        } else {
          _showNoDateSnackBar();
        }
      }
    }
  }

  void _showNoDateSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(AppDictionary.nonexistentDate),
      ),
    );
  }

  void _scrollToKey(GlobalKey key) {
    final currentContext = key.currentContext;
    if (currentContext != null) {
      Scrollable.ensureVisible(
        currentContext,
        duration: const Duration(
          seconds: 1,
        ),
      );
    }
  }

  Future<void> _loadNotes() async {
    final previousData = _notesListState.value.data;
    _notesListState.loading(previousData);
    try {
      final notesList = await model.loadNotes();
      final groups = groupBy(notesList, (item) => item.date);
      final newData = {
        for (final key in groups.keys.sorted(
          (a, b) => a.compareTo(b),
        ))
          key: (GlobalKey(), groups[key]!)
      };
      _notesListState.content(newData);
    } on Exception catch (e) {
      Logger.d(e.toString());
    }
  }

  @override
  ValueListenable<EntityState<Map<DateTime, (GlobalKey, List<Note>)>>>
      get notesListState => _notesListState;

  @override
  Future<void> goToNewNoteScreen() async {
    final route = MaterialPageRoute(
      builder: (_) => const AddNoteScreen(),
    );
    final newNote = await Navigator.of(context).push(route);
    if (newNote != null) {
      final maybeData = _notesListState.value.data;
      final note = newNote as Note;
      if (maybeData != null) {
        _notesListState.loading(maybeData);
        if (maybeData.containsKey(note.date)) {
          maybeData[note.date]!.$2.add(note);
        } else {
          maybeData[note.date] = (GlobalKey(), [note]);
        }
        _notesListState.content(maybeData);
      }
    }
  }
}

/// Factory for widget model [NotesListScreenWidgetModel].
NotesListScreenWidgetModel notesListScreenWMFactory(BuildContext context) {
  final INoteRepository noteRepository =
      MockNoteRepository(dataProvider: MockNoteDataProvider());
  final model = NotesListScreenModel(noteRepository);
  return NotesListScreenWidgetModel(model);
}

/// Interface of [NotesListScreenWidgetModel]
abstract interface class INotesListWidgetModel implements IWidgetModel {
  /// Entity state notifier for notes.
  ValueListenable<EntityState<Map<DateTime, (GlobalKey, List<Note>)>>>
      get notesListState;

  /// Get date and initiate scroll movement.
  Future<void> goToDay();

  /// Opens new note screen.
  Future<void> goToNewNoteScreen();
}
