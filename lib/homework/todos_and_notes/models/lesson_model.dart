import 'package:flutter_lesson_49/homework/todos_and_notes/models/quiz_model.dart';

class Lesson {
  final int courseId;
  final int lessonId;
  String lessonTitle;
  String lessonDescription;
  String imageUrl;
  //String videoUrl;
  //List<Quiz> lessonQuiz;

  Lesson({
    required this.lessonId,
    required this.courseId,
    required this.lessonTitle,
    required this.lessonDescription,
    required this.imageUrl
    //required this.videoUrl,
    //required this.lessonQuiz,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      lessonId: json['lesson-id'] as int? ?? 0,
      courseId: json['course-id']as int? ?? 0,
      lessonTitle: json['lesson-title']as String? ?? "",
      lessonDescription: json['lesson-description']as String? ?? "",
      imageUrl: json['lesson-image'] as String? ?? "",
      // videoUrl: json['lesson-videourl']as String? ?? "",
      // lessonQuiz: (json['lesson-quiz'] as List)
      //     .map((quiz) => Quiz.fromJson(quiz as Map<String, dynamic>? ??{}))
      //     .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lesson-id': lessonId,
      'course-id': courseId,
      'lesson-title': lessonTitle,
      'lesson-description': lessonDescription,
      // 'lesson-videourl': videoUrl,
      // 'lesson-quiz': lessonQuiz,
    };
  }
}