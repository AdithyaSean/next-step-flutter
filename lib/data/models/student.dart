class Student {
  final String id;
  final String name;
  final String email;
  final String? contact;
  final String? school;
  final String district;
  final String password;
  final Map<String, String> olResults;
  final Map<String, String> alResults;
  final String? stream;
  final double? zScore;
  final List<String> interests;
  final List<String> skills;
  final List<String> strengths;
  final List<CareerPrediction> predictions;

  Student({
    required this.id,
    required this.name,
    required this.email,
    this.contact,
    this.school,
    required this.district,
    required this.password,
    required this.olResults,
    required this.alResults,
    this.stream,
    this.zScore,
    required this.interests,
    required this.skills,
    required this.strengths,
    this.predictions = const [],
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'contact': contact,
    'school': school,
    'district': district,
    'password': password,
    'olResults': olResults,
    'alResults': alResults,
    'stream': stream,
    'zScore': zScore,
    'interests': interests,
    'skills': skills,
    'strengths': strengths,
    'predictions': predictions.map((p) => p.toJson()).toList(),
  };

  factory Student.fromJson(Map<String, dynamic> json) => Student(
    id: json['id'] as String,
    name: json['name'] as String,
    email: json['email'] as String,
    contact: json['contact'] as String?,
    school: json['school'] as String?,
    district: json['district'] as String,
    password: json['password'] as String,
    olResults: Map<String, String>.from(json['olResults']),
    alResults: Map<String, String>.from(json['alResults']),
    stream: json['stream'] as String?,
    zScore: json['zScore'] as double?,
    interests: List<String>.from(json['interests']),
    skills: List<String>.from(json['skills']),
    strengths: List<String>.from(json['strengths']),
    predictions: (json['predictions'] as List?)
        ?.map((e) => CareerPrediction.fromJson(e))
        .toList() ?? [],
  );
}

class CareerPrediction {
  final String careerPath;
  final double probability;
  final DateTime predictedAt;

  CareerPrediction({
    required this.careerPath,
    required this.probability,
    required this.predictedAt,
  });

  Map<String, dynamic> toJson() => {
    'careerPath': careerPath,
    'probability': probability,
    'predictedAt': predictedAt.toIso8601String(),
  };

  factory CareerPrediction.fromJson(Map<String, dynamic> json) => CareerPrediction(
    careerPath: json['careerPath'] as String,
    probability: json['probability'] as double,
    predictedAt: DateTime.parse(json['predictedAt'] as String),
  );
}