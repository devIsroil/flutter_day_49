import 'package:flutter/material.dart';


import '../../viewmodels/notes_view_model.dart';
import 'note_alert_dialog.dart';
import 'note_icon_button.dart';

class CustomNoteContainer extends StatelessWidget {
  final int index;
  final NoteController noteController;

  const CustomNoteContainer({
    super.key,
    required this.index,
    required this.noteController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20,left: 10,right: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.amber)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(noteController.notesList[index].noteTitle),
                Text(
                  noteController.notesList[index].noteCreatedDate
                      .toString()
                      .split(' ')[0],
                ),
              ],
            ),
            Text(noteController.notesList[index].noteContent),
            Row(
              children: [
                CustomIconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => NotesAlertDialog(
                          noteController: noteController,
                          isEdit: true,
                          index: index,
                        ),
                      );
                    },
                    icon: Icons.edit),
                CustomIconButton(
                  onPressed: () {
                    noteController.deleteNote(noteIndex: index);
                  },
                  icon: Icons.delete,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}