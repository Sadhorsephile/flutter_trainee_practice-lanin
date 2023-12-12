/// Note model.
class Note {
  /// @nodoc
  Note({required this.title, required this.description, required this.date});

  /// Title.
  final String title;

  /// Body of note.
  final String description;

  /// Date of last modification.
  final DateTime date;
}
