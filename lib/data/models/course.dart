class Course {
  final String id;
  final String name;
  final String description;
  final String duration;
  final String streamId;
  final Map<String, String> minimumALGrades;
  final double minimumZScore;
  final List<String> offeredByInstitutions;
  final List<String> relatedCareers;

  Course({
    required this.id,
    required this.name,
    required this.description,
    required this.duration,
    required this.streamId,
    required this.minimumALGrades,
    required this.minimumZScore,
    required this.offeredByInstitutions,
    required this.relatedCareers,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'duration': duration,
    'streamId': streamId,
    'minimumALGrades': minimumALGrades,
    'minimumZScore': minimumZScore,
    'offeredByInstitutions': offeredByInstitutions,
    'relatedCareers': relatedCareers,
  };

  factory Course.fromJson(Map<String, dynamic> json) => Course(
    id: json['id'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
    duration: json['duration'] as String,
    streamId: json['streamId'] as String,
    minimumALGrades: Map<String, String>.from(json['minimumALGrades']),
    minimumZScore: json['minimumZScore'] as double,
    offeredByInstitutions: List<String>.from(json['offeredByInstitutions']),
    relatedCareers: List<String>.from(json['relatedCareers']),
  );
}
