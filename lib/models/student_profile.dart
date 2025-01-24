class StudentProfile {
  final int educationLevel;
  final Map<String, double> olResults;
  final int alStream;
  final Map<String, double> alResults;
  final double gpa;

  StudentProfile({
    required this.educationLevel,
    required this.olResults,
    required this.alStream,
    required this.alResults,
    required this.gpa,
  });

  factory StudentProfile.fromJson(Map<String, dynamic> json) {
    return StudentProfile(
      educationLevel: json['educationLevel'],
      olResults: Map<String, double>.from(json['olResults']),
      alStream: json['alStream'],
      alResults: Map<String, double>.from(json['alResults']),
      gpa: json['gpa'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'educationLevel': educationLevel,
      'olResults': olResults,
      'alStream': alStream,
      'alResults': alResults,
      'gpa': gpa,
    };
  }
}
