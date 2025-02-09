import "package:next_step/utils/education_config.dart";
import 'package:flutter/foundation.dart';

class User {
  final String id;
  final String username;
  final String name;
  final String email;
  String password;
  final String telephone;
  final String role;
  final String school;
  final String district;
  final bool active;
  final DateTime createdAt;
  final DateTime updatedAt;

  int educationLevel;
  Map<String, double> olResults;
  int? alStream;
  Map<String, double> alResults;
  Map<String, double> careerProbabilities;
  double gpa;

  User({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
    this.password = '',
    required this.telephone,
    required this.role,
    required this.school,
    required this.district,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
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
      id: json['id']?.toString() ?? '',
      username: json['username']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      telephone: json['telephone']?.toString() ?? '',
      role: json['role']?.toString() ?? '',
      school: json['school']?.toString() ?? '',
      district: json['district']?.toString() ?? '',
      active: json['active'] as bool? ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'].toString())
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'].toString())
          : DateTime.now(),
    );
  }

  factory User.empty() {
    return User(
      id: '',
      username: '',
      name: '',
      email: '',
      telephone: '',
      role: 'STUDENT',
      school: '',
      district: '',
      active: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  factory User.fromProfile(Map<String, dynamic> json) {
    final user = User.fromJson(json);
    user.updateFromProfile(json);
    return user;
  }

  void updateFromProfile(Map<String, dynamic> json) {
    // First update education level as this affects what other fields we expect
    educationLevel = json['educationLevel'] ?? 0;

    // Always clear existing profile data
    olResults = {};
    alResults = {};
    alStream = null;
    gpa = 0.0;
    careerProbabilities = {};

    // All education levels need OL results
    if (json['olResults'] != null) {
      try {
        final Map rawMap = json['olResults'] as Map;
        olResults = Map<String, double>.fromEntries(rawMap.entries.map(
            (e) => MapEntry(e.key.toString(), (e.value as num).toDouble())));
      } catch (e) {
        debugPrint('Error parsing OL results: $e');
        olResults = {};
      }
    }

    // AL and University students need AL stream and results
    if (educationLevel >= 1) {
      if (json['alStream'] != null) {
        try {
          alStream = (json['alStream'] as num).toInt();
        } catch (e) {
          debugPrint('Error parsing AL stream: $e');
          alStream = null;
        }
      }

      if (json['alResults'] != null) {
        try {
          final Map rawMap = json['alResults'] as Map;
          alResults = Map<String, double>.fromEntries(rawMap.entries.map(
              (e) => MapEntry(e.key.toString(), (e.value as num).toDouble())));
        } catch (e) {
          debugPrint('Error parsing AL results: $e');
          alResults = {};
        }
      }
    }

    // Only University students need GPA
    if (educationLevel == 2 && json['gpa'] != null) {
      try {
        gpa = (json['gpa'] as num).toDouble();
      } catch (e) {
        debugPrint('Error parsing GPA: $e');
        gpa = 0.0;
      }
    }

    // Career probabilities are optional for all levels
    if (json['careerProbabilities'] != null) {
      try {
        final Map rawMap = json['careerProbabilities'] as Map;
        careerProbabilities = Map<String, double>.fromEntries(
            rawMap.entries.map((e) => MapEntry(e.key.toString(), (e.value as num).toDouble())));
      } catch (e) {
        debugPrint('Error parsing career probabilities: $e');
        careerProbabilities = {};
      }
    }

    debugPrint('Profile updated with educationLevel: $educationLevel');
    debugPrint('OL Results: $olResults');
    if (educationLevel >= 1) {
      debugPrint('AL Stream: $alStream');
      debugPrint('AL Results: $alResults');
    }
    if (educationLevel == 2) {
      debugPrint('GPA: $gpa');
    }
  }

  User copyWith({
    String? id,
    String? username,
    String? name,
    String? email,
    String? password,
    String? telephone,
    String? role,
    String? school,
    String? district,
    bool? active,
    DateTime? createdAt,
    DateTime? updatedAt,
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
      school: school ?? this.school,
      district: district ?? this.district,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      educationLevel: educationLevel ?? this.educationLevel,
      olResults: olResults ?? Map<String, double>.from(this.olResults),
      alStream: alStream ?? this.alStream,
      alResults: alResults ?? Map<String, double>.from(this.alResults),
      careerProbabilities: careerProbabilities ??
          Map<String, double>.from(this.careerProbabilities),
      gpa: gpa ?? this.gpa,
    );
  }

  // Validation methods for profile completeness
  bool hasValidOLResults() {
    return EducationConfig.requiredOLSubjects.every((subject) => 
      olResults.containsKey(subject) && olResults[subject] != EducationConfig.gradeNotSet);
  }

  bool hasValidALResults() {
    if (alStream == null) return false;
    final requiredSubjects = EducationConfig.streamSubjects[alStream] ?? [];
    return requiredSubjects.every((subject) => 
      alResults.containsKey(subject) && alResults[subject] != EducationConfig.gradeNotSet);
  }

  bool isProfileComplete() {
    if (!hasValidOLResults()) return false;
    
    switch (educationLevel) {
      case 1: // AL
        return hasValidALResults();
      case 2: // University
        return hasValidALResults() && gpa > 0 && gpa <= 4.0;
      default:
        return true; // OL only needs valid OL results
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'name': name,
      'email': email,
      'telephone': telephone,
      'role': role,
      'school': school,
      'district': district,
      'active': active,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'educationLevel': educationLevel,
      'olResults': olResults,
      'alStream': alStream,
      'alResults': alResults,
      'careerProbabilities': careerProbabilities,
      'gpa': gpa,
    };
  }
}
