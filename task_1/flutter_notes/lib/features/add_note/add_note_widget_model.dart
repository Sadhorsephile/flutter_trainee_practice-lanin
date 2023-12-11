import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notes/domain/note/note.dart';
import 'package:flutter_notes/features/add_note/add_note_model.dart';
import 'package:flutter_notes/features/add_note/add_note_widget.dart';

/// Widget model class for [AddNoteScreen]
class AddNoteScreenWidgetModel
    extends WidgetModel<AddNoteScreen, AddNoteScreenModel>
    implements IAddNoteWidgetModel {
  /// @nodoc
  AddNoteScreenWidgetModel(super._model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  String body = '';

  @override
  String title = '';

  @override
  void createNewNote() {}

  @override
  void goToNotesScreen() {
    Future.delayed(
      Duration.zero,
      () {
        final currentTime = DateTime.now();
        Navigator.of(context).pop(title != ''
            ? Note(
                title: title,
                description: body,
                date: DateTime(
                    currentTime.year, currentTime.month, currentTime.day),
              )
            : null);
      },
    );
  }
}

/// Factory for widget model [AddNoteScreenWidgetModel].
AddNoteScreenWidgetModel addNoteScreenWMFactory(BuildContext context) {
  final model = AddNoteScreenModel();
  return AddNoteScreenWidgetModel(model);
}

/// Interface of [AddNoteScreenWidgetModel]
abstract interface class IAddNoteWidgetModel implements IWidgetModel {
  /// Title of new note.
  String get title;

  /// Body of new note.
  String get body;
  set title(String val);
  set body(String val);

  /// Callback for saving new note.
  void createNewNote();

  /// Closes new note screen.
  void goToNotesScreen();
}
