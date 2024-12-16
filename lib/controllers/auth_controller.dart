
import '../data/repositories/student_repository.dart';

class AuthController {
  final StudentRepository _studentRepository;
  
  AuthController(this._studentRepository);

  Future<void> signUp({
    required String username,
    required String name,
    required String email,
    required String contact,
    required String school,
    required String district,
    required String password,
  }) async {
    final studentData = {
      'id': username,
      'name': name,
      'email': email,
      'contact': contact,
      'school': school,
      'district': district,
      'password': password,
      'olResults': <String, String>{},
      'alResults': <String, String>{},
      'stream': '',
      'zScore': 0.0,
      'interests': <String>[],
      'skills': <String>[],
      'strengths': <String>[],
      'predictions': <String, Map<String, dynamic>>{},
    };

    await _studentRepository.createStudent(studentData);
  }
}