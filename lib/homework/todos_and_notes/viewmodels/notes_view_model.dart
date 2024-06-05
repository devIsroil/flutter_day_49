import 'package:flutter/cupertino.dart';

import '../models/notes_model.dart';

class NoteController with ChangeNotifier {
  final List<NoteModel> _notesList = [];

  List<NoteModel> get notesList => [..._notesList];

  void addNote({
    required String noteTitle,
    required String noteContent,
  }) {
    _notesList.add(
      NoteModel(
        noteId: _notesList.length,
        noteTitle: noteTitle,
        noteContent: noteContent,
        noteCreatedDate: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  void editNote({
    required int noteIndex,
    required String noteTitle,
    required String noteContent,
  }) {
    _notesList[noteIndex].noteTitle = noteTitle;
    _notesList[noteIndex].noteContent = noteContent;
    notifyListeners();
  }

  void deleteNote({
    required int noteIndex,
  }) {
    _notesList.removeAt(noteIndex);
    notifyListeners();
  }
}