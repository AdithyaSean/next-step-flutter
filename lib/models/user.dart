import 'package:flutter/foundation.dart';

class User {
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
  final String? school;
  final String? district;
  final int educationLevel; // 0=O/L, 1=A/L, 2=University
  final Map<String, double> olResults;
  final int? alStream; // 6=Physical, 7=Bio, 8=ICT, 9=Agriculture
  final Map<String, double> alResults;
  final Map<String, double> careerProbabilities;
  final double gpa;

  User({
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
    this.school,
    this.district,
    this.educationLevel = 0,
    Map<String, double>? olResults,
    this.alStream,
    Map<String, double>? alResults,
    Map<String, double>? careerProbabilities,
    this.gpa = 0.0,
  })  : olResults = olResults ?? {},
        alResults = alResults ?? {},
        careerProbabilities = careerProbabilities ?? {};

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      username: json['username'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      telephone: json['telephone'] ?? '',
      role: json['role'] ?? '',
      active: json['active'] ?? false,
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
      school: json['school'],
      district: json['district'],
      educationLevel: json['educationLevel'] ?? 0,
      olResults: Map<String, double>.from(json['olResults'] ?? {}),
      alStream: json['alStream'],
      alResults: Map<String, double>.from(json['alResults'] ?? {}),
      careerProbabilities: Map<String, double>.from(json['careerProbabilities'] ?? {}),
      gpa: json['gpa']?.toDouble() ?? 0.0,
    );
  }

    Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'name': name,
      'email': email,
      'password': password,
      'telephone': telephone,
      'role': role,
      'active': active,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'school': school,
      'district': district,
      'educationLevel': educationLevel,
      'olResults': olResults,
      'alStream': alStream,
      'alResults': alResults,
      'careerProbabilities': careerProbabilities,
      'gpa': gpa,
    };
  }

  bool isProfileComplete() {
    debugPrint('isProfileComplete check: educationLevel=$educationLevel, olResults=$olResults, alStream=$alStream, alResults=$alResults, gpa=$gpa');

    // For all levels, OL results are required
    if (olResults.isEmpty) {
      debugPrint('isProfileComplete: false - missing OL results');
      return false;
    }

    // For AL students
    if (educationLevel == 1) {
      if (alStream == null || alResults.isEmpty) {
        debugPrint('isProfileComplete: false - AL student missing stream or results');
        return false;
      }
    }

    // For University students
    if (educationLevel == 2) {
      if (alStream == null || alResults.isEmpty) {
        debugPrint('isProfileComplete: false - University student missing AL info');
        return false;
      }
      if (gpa == 0.0) {
        debugPrint('isProfileComplete: false - University student missing GPA');
        return false;
      }
    }

    debugPrint('isProfileComplete: true - all required fields present for level $educationLevel');
    return true;
  }

  User copyWith({
    String? id,
    String? username,
    String? name,
    String? email,
    String? password,
    String? telephone,
    String? role,
    bool? active,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? school,
    String? district,
    int? educationLevel,
    Map<String, double>? olResults,
    int? alStream,
    Map<String, double>? alResults,
    Map<String, double>? careerProbabilities,
    double? gpa,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      telephone: telephone ?? this.telephone,
      role: role ?? this.role,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      school: school ?? this.school,
      district: district ?? this.district,
      educationLevel: educationLevel ?? this.educationLevel,
      olResults: olResults ?? this.olResults,
      alStream: alStream ?? this.alStream,
      alResults: alResults ?? this.alResults,
      careerProbabilities: careerProbabilities ?? this.careerProbabilities,
      gpa: gpa ?? this.gpa,
    );
  }
}
