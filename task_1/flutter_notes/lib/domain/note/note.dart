/// Note model.
class Note {
  /// Title.
  String title;

  /// Body of note.
  String description;

  /// Date of last modification.
  DateTime date;

  /// @nodoc
  Note({required this.title, required this.description, required this.date});
}
