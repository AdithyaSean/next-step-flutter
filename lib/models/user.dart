class UserDTO {
  final String id;
  final String username;
  final String name;
  final String email;
  final String password;
  final String telephone;
  final String role;
  final bool active;
  final DateTime createdAt;
  final DateTime updatedAt;
  final StudentDTO? student;

  UserDTO({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
    required this.password,
    required this.telephone,
    required this.role,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
    this.student,
  });

  factory UserDTO.fromJson(Map<String, dynamic> json) {
    return UserDTO(
      id: json['id'],
      username: json['username'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      telephone: json['telephone'],
      role: json['role'],
      active: json['active'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      student: json['student'] != null ? StudentDTO.fromJson(json['student']) : null,
    );
  }
}

class StudentDTO {
  final String school;
  final String district;
  final StudentProfileDTO? studentProfile;

  StudentDTO({
    required this.school,
    required this.district,
    this.studentProfile,
  });

  factory StudentDTO.fromJson(Map<String, dynamic> json) {
    return StudentDTO(
      school: json['school'],
      district: json['district'],
      studentProfile: json['studentProfile'] != null ? StudentProfileDTO.fromJson(json['studentProfile']) : null,
    );
  }
}

class StudentProfileDTO {
  final String id;
  final int educationLevel;
  final Map<String, double> olResults;
  final int? alStream;
  final Map<String, double> alResults;
  final Map<String, double> careerProbabilities;
  final double gpa;
  final DateTime createdAt;
  final DateTime updatedAt;

  StudentProfileDTO({
    required this.id,
    required this.educationLevel,
    required this.olResults,
    this.alStream,
    required this.alResults,
    required this.careerProbabilities,
    required this.gpa,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StudentProfileDTO.fromJson(Map<String, dynamic> json) {
    return StudentProfileDTO(
      id: json['id'],
      educationLevel: json['educationLevel'],
      olResults: Map<String, double>.from(json['olResults']),
      alStream: json['alStream'],
      alResults: Map<String, double>.from(json['alResults']),
      careerProbabilities: Map<String, double>.from(json['careerProbabilities']),
      gpa: json['gpa'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}