class StudentProfile {
  String name;
  String email;
  String phone;
  List<String> certifications;
  List<String> interests;
  int educationLevel;
  Map<String, double> olResults;
  int alStream;
  Map<String, double> alResults;
  double gpa;

  StudentProfile({
    this.name = '',
    this.email = '',
    this.phone = '',
    this.certifications = const [],
    this.interests = const [],
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
