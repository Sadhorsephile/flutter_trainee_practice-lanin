import 'package:hive/hive.dart';

part 'note.g.dart';

/// Note model.
@HiveType(typeId: 0)
class Note {
  /// @nodoc
  Note({required this.title, required this.description, required this.date});

  /// Title.
  @HiveField(0)
  String title;

  /// Body of note.
  @HiveField(1)
  String description;

  /// Date of last modification.
  @HiveField(2)
  DateTime date;
}
