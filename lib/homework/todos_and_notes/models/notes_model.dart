
class NoteModel {
  final int noteId;
  String noteTitle;
  String noteContent;
  DateTime noteCreatedDate;

  NoteModel({
    required this.noteId,
    required this.noteTitle,
    required this.noteContent,
    required this.noteCreatedDate,
  });
}
