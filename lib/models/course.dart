import 'institution.dart';

class Course {
  final String id;
  final String name;
  final String description;
  final String duration;
  final Stream stream;
  final Map<String, String> minimumALGrades;
  final double minimumZScore;
  final List<Institution> offeredBy;
  final List<String> relatedCareers;

  Course({
    required this.id,
    required this.name,
    required this.description,
    required this.duration,
    required this.stream,
    required this.minimumALGrades,
    required this.minimumZScore,
    required this.offeredBy,
    required this.relatedCareers,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      duration: json['duration'],
      stream: Stream.value(json['stream']),
      minimumALGrades: Map<String, String>.from(json['minimumALGrades']),
      minimumZScore: json['minimumZScore'],
      offeredBy: (json['offeredBy'] as List)
          .map((i) => Institution.fromJson(i))
          .toList(),
      relatedCareers: List<String>.from(json['relatedCareers']),
    );
  }
}
