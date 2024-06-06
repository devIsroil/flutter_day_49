
import 'lesson_model.dart';

class Course {
  String courseId;
  String courseTitle;
  String courseDescription;
  String courseImageUrl;
  List<Lesson> courseLessons;
  num coursePrice;

  Course({
    required this.courseId,
    required this.courseTitle,
    required this.courseDescription,
    required this.courseImageUrl,
    required this.courseLessons,
    required this.coursePrice,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      courseId: json['id']as String? ?? "",
      courseTitle: json['course-title']as String? ?? "" ,
      courseDescription: json['course-description'] as String? ?? "",
      courseImageUrl: json['course-image']as String? ?? "",
      courseLessons: (json['course-lessons'] as List? ?? [])
          .map((lesson) => Lesson.fromJson(lesson as Map<String, dynamic>? ?? {}))
          .toList(),
      coursePrice: json['course-price'] as num? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': courseId,
      'course-title': courseTitle,
      'course-description': courseDescription,
      'course-image': courseImageUrl,
      'course-lessons': courseLessons,
      'course-price': coursePrice,
    };
  }
}