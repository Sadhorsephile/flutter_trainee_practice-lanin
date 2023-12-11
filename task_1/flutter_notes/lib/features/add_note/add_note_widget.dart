import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notes/features/add_note/add_note_widget_model.dart';
import 'package:flutter_notes/util/app_dictionary.dart';

/// Screen with new note editing page.
class AddNoteScreen extends ElementaryWidget<IAddNoteWidgetModel> {
  /// @nodoc
  const AddNoteScreen(
      {Key? key, WidgetModelFactory wmFactory = addNoteScreenWMFactory})
      : super(wmFactory, key: key);

  @override
  Widget build(IAddNoteWidgetModel wm) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppDictionary.newNoteAppBarTitle),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: wm.goToNotesScreen,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: wm.titleController,
                    decoration: const InputDecoration(
                        hintText: AppDictionary.titleString),
                  ),
                  TextFormField(
                    controller: wm.bodyController,
                    decoration: const InputDecoration(
                        hintText: AppDictionary.descriptionString),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: wm.goToNotesScreen,
                    child: const Text(AppDictionary.saveNote),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
