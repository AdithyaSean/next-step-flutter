import 'course.dart';

class Stream {
  final String id;
  final String name;
  final String description;
  final List<String> requiredOLSubjects;
  final Map<String, String> minimumOLGrades;
  final List<Course> possibleCourses;
  final List<String> relatedCareers;

  Stream({
    required this.id,
    required this.name,
    required this.description,
    required this.requiredOLSubjects,
    required this.minimumOLGrades,
    required this.possibleCourses,
    required this.relatedCareers,
  });

  factory Stream.fromJson(Map<String, dynamic> json) {
    return Stream(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      requiredOLSubjects: List<String>.from(json['requiredOLSubjects']),
      minimumOLGrades: Map<String, String>.from(json['minimumOLGrades']),
      possibleCourses: (json['possibleCourses'] as List)
          .map((i) => Course.fromJson(i))
          .toList(),
      relatedCareers: List<String>.from(json['relatedCareers']),
    );
  }
}
