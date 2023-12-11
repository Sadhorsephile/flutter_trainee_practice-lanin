import 'package:hive/hive.dart';

part 'note.g.dart';

/// Note model.
@HiveType(typeId: 0)
class Note {
  /// @nodoc
  Note({required this.title, required this.description, required this.date});

  /// Title.
  final String title;

  /// Body of note.
  final String description;

  /// Date of last modification.
  final DateTime date;

  /// @nodoc
  Note({required this.title, required this.description, required this.date});
}
