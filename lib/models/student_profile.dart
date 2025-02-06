import 'package:next_step/utils/education_config.dart';

class StudentProfile {
  final String id;
  int educationLevel;
  Map<String, double> olResults;
  int? alStream;
  Map<String, double> alResults;
  Map<String, double> careerProbabilities;
  double gpa;

  StudentProfile({
    required this.id,
    this.educationLevel = 1, // Default to O/L
    Map<String, double>? olResults,
    this.alStream, // Default to Science stream
    Map<String, double>? alResults,
    Map<String, double>? careerProbabilities,
    this.gpa = 0.0,
  }) : 
    this.olResults = olResults ?? Map.fromEntries(
      EducationConfig.olSubjects.entries.map(
        (e) => MapEntry(e.key, 0.0)
      )
    ),
    this.alResults = alResults ?? {},
    this.careerProbabilities = careerProbabilities ?? {};

  factory StudentProfile.fromJson(Map<String, dynamic> json) => StudentProfile(
    id: json['id'],
    educationLevel: json['educationLevel'] ?? 0,
    olResults: Map<String, double>.from(json['olResults'] ?? {}),
    alStream: json['alStream'],
    alResults: Map<String, double>.from(json['alResults'] ?? {}),
    careerProbabilities: Map<String, double>.from(json['careerProbabilities'] ?? {}),
    gpa: json['gpa']?.toDouble() ?? 0.0,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'educationLevel': educationLevel,
    'olResults': olResults,
    'alStream': alStream,
    'alResults': alResults,
    'careerProbabilities': careerProbabilities,
    'gpa': gpa,
  };
}