import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notes/domain/note/note.dart';
import 'package:flutter_notes/features/notes_list/notes_list_widget_model.dart';
import 'package:flutter_notes/util/app_dictionary.dart';

/// Screen with list of notes.
class NotesListScreen extends ElementaryWidget<INotesListWidgetModel> {
  /// @nodoc
  const NotesListScreen({
    Key? key,
    WidgetModelFactory wmFactory = notesListScreenWMFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(INotesListWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppDictionary.notesListAppBarTitle),
        actions: [
          IconButton(
            onPressed: wm.goToDay,
            icon: const Icon(Icons.date_range),
          ),
        ],
      ),
      body: EntityStateNotifierBuilder(
        listenableEntityState: wm.notesListState,
        builder: (context, groups) {
          final size = MediaQuery.of(context).size;
          if (groups == null || groups.isEmpty) {
            return const _EmptyList();
          }
          // Returns delegate for builder of any sliver widget.
          SliverChildBuilderDelegate builderDelegate(
              (GlobalKey, List<Note>) section) {
            return SliverChildBuilderDelegate(
              childCount: section.$2.length,
              (_, index) {
                final currentNote = section.$2.elementAt(index);
                return NoteWidget(
                  title: currentNote.title,
                  body: currentNote.description,
                  date: currentNote.date,
                );
              },
            );
          }

          final sliv = <Widget>[];
          for (final entry in groups.entries) {
            sliv
              ..add(
                SliverPadding(
                  key: entry.value.$1,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Divider(),
                        Text(
                          entry.key
                              .toString()
                              .split(' ')
                              .first
                              .split('-')
                              .reversed
                              .join('/'),
                        ),
                        const Divider(),
                      ],
                    ),
                  ),
                ),
              )
              ..add(
                size.width < size.height
                    ? SliverList(
                        delegate: builderDelegate(entry.value),
                      )
                    : SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        sliver: SliverGrid(
                          delegate: builderDelegate(entry.value),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 1.7,
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                          ),
                        ),
                      ),
              );
          }

          return CustomScrollView(
            slivers: sliv,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: wm.goToNewNoteScreen,
        child: const Icon(
          Icons.edit,
        ),
      ),
    );
  }
}

/// Screen when there are no notes.
class _EmptyList extends StatelessWidget {
  const _EmptyList();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(AppDictionary.noNotesInList),
    );
  }
}

/// Widget for Note on [NotesListScreen]
class NoteWidget extends StatelessWidget {
  /// Title on note.
  final String title;

  /// Description of note.
  final String body;

  /// Date of creation.
  final DateTime date;

  /// Widget for note's card.
  const NoteWidget(
      {required this.title, required this.body, required this.date, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              body,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
