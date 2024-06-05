
import 'package:flutter/material.dart';
import 'package:flutter_lesson_49/homework/todos_and_notes/views/screens/notes_screen.dart';
import 'package:flutter_lesson_49/homework/todos_and_notes/views/screens/todo_screen.dart';

import '../../models/course_model.dart';
import '../../viewmodels/course_view_model.dart';
import '../widgets/custom_inkwell_button.dart';
import '../widgets/custom_list_view_builder_container.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final CourseViewModel _courseViewModel = CourseViewModel();
  bool _isViewStylePressed = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomInkwellButton(
                nextPage: TodoScreen(),
                buttonText: 'Todos',
              ),
              CustomInkwellButton(
                nextPage: NoteScreen(),
                buttonText: 'Notes',
              ),
            ],
          ),
          //const SizedBox(height: 20),
          const SizedBox(height: 20),
          Expanded(
            child: FutureBuilder(
              future: _courseViewModel.courseList,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError || !snapshot.hasData) {
                  return Center(child: Text('error: ${snapshot.error}'));
                } else {
                  List<Course> courseList = snapshot.data;
                  return _isViewStylePressed
                      ? GridView.builder(
                    itemCount: courseList.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1.3),
                    itemBuilder: (context, index) =>
                        CustomListViewBuilderContainer(
                          isViewStylePressed: _isViewStylePressed,
                          course: courseList[index],
                          isDelete: false,
                        ),
                  )
                      : ListView.builder(
                    itemCount: courseList.length,
                    itemBuilder: (BuildContext context, int index) =>
                        CustomListViewBuilderContainer(
                          isViewStylePressed: _isViewStylePressed,
                          course: courseList[index],
                          isDelete: false,
                        ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}