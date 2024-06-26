import 'package:flutter/material.dart';
import '../../models/course_model.dart';
import '../../models/lesson_model.dart';
import '../../models/quiz_model.dart';
import '../../viewmodels/course_view_model.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/custom_list_view_builder_container.dart';

class CourseAdminScreen extends StatefulWidget {
  final ValueChanged<bool> onThemeChanged;
  final ValueChanged<String> onBackgroundChanged;
  final ValueChanged<String> onLanguageChanged;
  final ValueChanged<Color> onColorChanged;
  final Function(Color, double) onTextChanged;

  const CourseAdminScreen({
    super.key,
    required this.onThemeChanged,
    required this.onBackgroundChanged,
    required this.onLanguageChanged,
    required this.onColorChanged,
    required this.onTextChanged,
  });

  @override
  State<CourseAdminScreen> createState() => _CourseAdminScreenState();
}

class _CourseAdminScreenState extends State<CourseAdminScreen> {
  final List<TextEditingController> _courseTextEditingControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  final List<TextEditingController> _lessonTextEditingControllers = [
    TextEditingController(),
    TextEditingController(),
  ];

  final CourseViewModel _courseViewModel = CourseViewModel();
  bool isTextFieldEmpty = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course admin',),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: ListView(
          children: [
            TextField(
              controller: _courseTextEditingControllers[0],
              decoration: const InputDecoration(
                hintText: 'course title',
              ),
            ),
            TextField(
              controller: _courseTextEditingControllers[1],
              decoration: const InputDecoration(
                hintText: 'course description',
              ),
            ),
            TextField(
              controller: _courseTextEditingControllers[2],
              decoration: const InputDecoration(
                hintText: 'course image url',
              ),
            ),
            TextField(
              controller: _courseTextEditingControllers[3],
              decoration: const InputDecoration(
                hintText: 'course price',
              ),
            ),
            Text(isTextFieldEmpty ? 'Fill all fields' : ''),
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Add lesson'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: _lessonTextEditingControllers[0],
                          decoration: const InputDecoration(
                            hintText: 'lesson title',
                          ),
                        ),
                        TextField(
                          controller: _lessonTextEditingControllers[1],
                          decoration: const InputDecoration(
                            hintText: 'lesson description',
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Save'),
                      ),
                      // TextButton(
                      //   onPressed: () {
                      //     showDialog(
                      //       context: context,
                      //       builder: (context) => const AlertDialog(
                      //         title: Text('Add quiz'),
                      //       ),
                      //     );
                      //   },
                      //   child: const Text('Add Quiz'),
                      // ),
                    ],
                  ),
                );
              },
              child: const Text('Add lesson'),
            ),
            TextButton(
              onPressed: () {
                isTextFieldEmpty = false;
                for (TextEditingController each
                in _courseTextEditingControllers) {
                  if (each.text.trim().isEmpty) {
                    isTextFieldEmpty = true;
                    break;
                  }
                }
                setState(() {});
                if (!isTextFieldEmpty) {
                  _courseViewModel.addCourse(
                    courseTitle: _courseTextEditingControllers[0].text,
                    courseDescription: _courseTextEditingControllers[1].text,
                    courseImageUrl: _courseTextEditingControllers[2].text,
                    courseLessons: [
                      //Course(courseId: , courseTitle: courseTitle, courseDescription: courseDescription, courseImageUrl: courseImageUrl, courseLessons: courseLessons, coursePrice: coursePrice),
                      Lesson(
                        lessonId: 2,
                        courseId: 2,
                        imageUrl: '',

                        lessonTitle: 'Programming',
                        lessonDescription: 'Flutter language',
                        //videoUrl: 'videoUrl',
                        // lessonQuiz: [
                        //   Quiz(
                        //     qCorrectAnswer: 0,
                        //     qId: 1,
                        //     qOptions: ['yes', 'no'],
                        //     qQuestion: 'Yes or no',
                        //   ),
                        // ],
                      )
                    ],
                    coursePrice: 0,
                  );
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text(
                        'Success',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Good'),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: const Text('Add course'),
            ),
            FutureBuilder(
                future: _courseViewModel.courseList,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError || !snapshot.hasData) {
                    return const Center(
                      child: Text('no courses'),
                    );
                  } else {
                    List<Course> courses = snapshot.data;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: courses.length,
                      itemBuilder: (BuildContext context, int index) =>
                          CustomListViewBuilderContainer(
                            course: courses[index],
                            isViewStylePressed: false,
                            isDelete: true,
                            onDeletePressed: () async {
                              await _courseViewModel.deleteCourse(
                                id: courses[index].courseId,
                              );
                              setState(() {});
                            },
                          ),
                    );
                  }
                })
          ],
        ),
      ),
      drawer: CustomDrawer(
        onThemeChanged: widget.onThemeChanged,
        onBackgroundChanged: widget.onBackgroundChanged,
        onLanguageChanged: widget.onLanguageChanged,
        onColorChanged: widget.onColorChanged,
        onTextChanged: widget.onTextChanged,
      ),
    );
  }
}