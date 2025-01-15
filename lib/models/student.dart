class Student {
  final String id;
  final String name;
  final String email;
  final String contact;
  final String school;
  final String district;
  final String password;
  final Map<String, double> olResults;
  final Map<String, double> alResults;
  final int stream;
  final double zScore;
  final double gpa;
  final List<String> interests;
  final List<String> skills;
  final List<CareerPrediction> predictions;
  final String firebaseUid;
  final String firebaseToken;

  Student({
    required this.id,
    required this.name,
    required this.email,
    required this.contact,
    required this.school,
    required this.district,
    required this.password,
    required this.olResults,
    required this.alResults,
    required this.stream,
    required this.zScore,
    required this.gpa,
    required this.interests,
    required this.skills,
    required this.predictions,
    required this.firebaseUid,
    required this.firebaseToken,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      contact: json['contact'],
      school: json['school'],
      district: json['district'],
      password: json['password'],
      olResults: Map<String, double>.from(json['olResults'] ?? {}),
      alResults: Map<String, double>.from(json['alResults'] ?? {}),
      stream: json['stream'] ?? 0,
      zScore: json['zScore'] ?? 0.0,
      gpa: json['gpa'] ?? 0.0,
      interests: List<String>.from(json['interests'] ?? []),
      skills: List<String>.from(json['skills'] ?? []),
      predictions: (json['predictions'] as List<dynamic>?)
              ?.map((i) => CareerPrediction.fromJson(i))
              .toList() ??
          [],
      firebaseUid: json['firebaseUid'],
      firebaseToken: json['firebaseToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
      'gpa': gpa,
      'interests': interests,
      'skills': skills,
      'predictions': predictions.map((prediction) => prediction.toJson()).toList(),
      'firebaseUid': firebaseUid,
      'firebaseToken': firebaseToken,
    };
  }
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

  factory CareerPrediction.fromJson(Map<String, dynamic> json) {
    return CareerPrediction(
      careerPath: json['careerPath'],
      probability: json['probability'],
      predictedAt: DateTime.parse(json['predictedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'careerPath': careerPath,
      'probability': probability,
      'predictedAt': predictedAt.toIso8601String(),
    };
  }
}