import 'package:flutter/material.dart';

import '../../notifier/notes_notifier.dart';
import '../../viewmodels/notes_view_model.dart';
import '../widgets/note_alert_dialog.dart';
import '../widgets/note_container.dart';


class NoteScreen extends StatelessWidget {
  const NoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NoteController noteController = NoteNotifier.of(context);
    return ListenableBuilder(
      listenable: NoteNotifier.of(context),
      builder: (BuildContext context, Widget? child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          automaticallyImplyLeading: false,
          title: const Text('Notes'),
          centerTitle: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => NotesAlertDialog(
                      noteController: noteController,
                      isEdit: false,
                      index: 0,
                    ),
                  );
                },
                child: const Text('Add note'),
              ),
            ),
          ],
        ),
        body: noteController.notesList.isEmpty
            ?  Center(
          child: Text('There are no notes'),
        )
            : ListView.builder(
          itemCount: noteController.notesList.length,
          itemBuilder: (context, index) {
            return CustomNoteContainer(
              index: index,
              noteController: noteController,
            );
          },
        ),
      ),
    );
  }
}