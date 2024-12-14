class Student {
  final String id;
  final String name;
  final String email;
  final String contact;
  final String school;
  final String district;
  final Map<String, String> olResults;
  final Map<String, String> alResults;
  final String stream;
  final double zScore;
  final List<String> interests;
  final List<String> skills;
  final List<CareerPrediction> predictions;

  Student({
    required this.id,
    required this.name,
    required this.email,
    required this.contact,
    required this.school,
    required this.district,
    required this.olResults,
    required this.alResults,
    required this.stream,
    required this.zScore,
    required this.interests,
    required this.skills,
    required this.predictions,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      contact: json['contact'],
      school: json['school'],
      district: json['district'],
      olResults: Map<String, String>.from(json['olResults']),
      alResults: Map<String, String>.from(json['alResults']),
      stream: json['stream'],
      zScore: json['zScore'],
      interests: List<String>.from(json['interests']),
      skills: List<String>.from(json['skills']),
      predictions: (json['predictions'] as List)
          .map((i) => CareerPrediction.fromJson(i))
          .toList(),
    );
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
}
