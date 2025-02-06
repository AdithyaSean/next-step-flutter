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
    this.alStream = 1, // Default to Science stream
    Map<String, double>? alResults,
    Map<String, double>? careerProbabilities,
    this.gpa = 0.0,
  }) : 
    this.olResults = olResults ?? {
      'Mathematics': 0.0,
      'Science': 0.0,
      'English': 0.0,
    },
    this.alResults = alResults ?? {
      'Subject 1': 0.0,
      'Subject 2': 0.0,
      'Subject 3': 0.0,
    },
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