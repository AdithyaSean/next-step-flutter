import 'course.dart';

class StudyStream {
  final String id;
  final String name;
  final String description;
  final List<String> requiredOLSubjects;
  final Map<String, String> minimumOLGrades;
  final List<Course> possibleCourses;
  final List<String> relatedCareers;

  StudyStream({
    required this.id,
    required this.name,
    required this.description,
    required this.requiredOLSubjects,
    required this.minimumOLGrades,
    required this.possibleCourses,
    required this.relatedCareers,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'requiredOLSubjects': requiredOLSubjects,
    'minimumOLGrades': minimumOLGrades,
    'possibleCourses': possibleCourses.map((c) => c.toJson()).toList(),
    'relatedCareers': relatedCareers,
  };

  factory StudyStream.fromJson(Map<String, dynamic> json) => StudyStream(
    id: json['id'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
    requiredOLSubjects: List<String>.from(json['requiredOLSubjects']),
    minimumOLGrades: Map<String, String>.from(json['minimumOLGrades']),
    possibleCourses: (json['possibleCourses'] as List)
        .map((c) => Course.fromJson(c))
        .toList(),
    relatedCareers: List<String>.from(json['relatedCareers']),
  );
}
