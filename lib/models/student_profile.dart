class StudentProfile {
  String? id;
  int educationLevel;
  Map<String, double> olResults;
  int? alStream;
  Map<String, double> alResults;
  Map<String, double> careerProbabilities;
  double? gpa;
  DateTime? createdAt;
  DateTime? updatedAt;

  StudentProfile({
    this.id,
    required this.educationLevel,
    Map<String, double>? olResults,
    this.alStream,
    Map<String, double>? alResults,
    Map<String, double>? careerProbabilities,
    this.gpa,
    this.createdAt,
    this.updatedAt,
  })  : olResults = olResults ?? {},
        alResults = alResults ?? {},
        careerProbabilities = careerProbabilities ?? {};

  factory StudentProfile.fromJson(Map<String, dynamic> json) {
    return StudentProfile(
      id: json['id'] as String?,
      educationLevel: json['educationLevel'] as int? ?? 0, // Default if null
      olResults: (json['olResults'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ) ?? {},
      alStream: json['alStream'] as int?,
      alResults: (json['alResults'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ) ?? {},
      careerProbabilities: (json['careerProbabilities'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ) ?? {},
      gpa: (json['gpa'] as num?)?.toDouble(),
      createdAt: json['createdAt'] == null ? null : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null ? null : DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'educationLevel': educationLevel,
      'olResults': olResults,
      'alStream': alStream,
      'alResults': alResults,
      'careerProbabilities': careerProbabilities,
      'gpa': gpa,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
