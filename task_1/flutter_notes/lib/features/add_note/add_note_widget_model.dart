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

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _bodyController = TextEditingController();

  @override
  void initWidgetModel() {
    _titleController.text = '';
    _bodyController.text = '';
    super.initWidgetModel();
  }

  @override
  void dispose() {
    _bodyController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  void createNewNote() {}

  @override
  void goToNotesScreen() {
    Future.delayed(
      Duration.zero,
      () {
        Navigator.of(context).pop(_titleController.text != ''
            ? Note(
                title: _titleController.text,
                description: _bodyController.text,
                date: DateTime.now(),
              )
            : null);
      },
    );
  }

  @override
  TextEditingController get titleController => _titleController;

  @override
  TextEditingController get bodyController => _bodyController;
}

/// Factory for widget model [AddNoteScreenWidgetModel].
AddNoteScreenWidgetModel addNoteScreenWMFactory(BuildContext context) {
  final model = AddNoteScreenModel();
  return AddNoteScreenWidgetModel(model);
}

/// Interface of [AddNoteScreenWidgetModel]
abstract interface class IAddNoteWidgetModel implements IWidgetModel {
  /// Text editing controller for title input.
  TextEditingController get titleController;

  /// Text editing controller for description input.
  TextEditingController get bodyController;

  /// Callback for saving new note.
  void createNewNote();

  /// Closes new note screen.
  void goToNotesScreen();
}
