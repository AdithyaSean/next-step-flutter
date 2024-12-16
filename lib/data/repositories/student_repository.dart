import '../database/app_database.dart';
import '../../services/firebase_db_service.dart';
import 'package:drift/drift.dart';

class StudentRepository {
  final AppDatabase _localDB;
  final FirebaseDBService _firebaseDB;

  StudentRepository(this._localDB, this._firebaseDB);

  Future<void> createStudent(Map<String, dynamic> studentData) async {
    final studentId = studentData['id'];
    
    // First, store in local database
    await _localDB.into(_localDB.students).insertOnConflictUpdate(
      StudentsCompanion.insert(
        id: studentId,
        name: studentData['name'] as String,
        email: studentData['email'] as String,
        contact: Value(studentData['contact'] as String),
        school: Value(studentData['school'] as String),
        district: studentData['district'] as String,
        password: studentData['password'] as String,
        olResults: studentData['olResults'] as Map<String, String>,
        alResults: studentData['alResults'] as Map<String, String>,
        stream: Value(studentData['stream'] as String),
        zScore: Value(studentData['zScore'] as double),
        interests: studentData['interests'] as List<String>,
        skills: studentData['skills'] as List<String>,
        strengths: studentData['strengths'] as List<String>,
        predictions: studentData['predictions'] as Map<String, Map<String, dynamic>>,
      ),
    );

    // Then, sync with Firebase
    await _firebaseDB.updateStudent(studentData, studentId);
  }

  Future<Map<String, dynamic>?> getStudent(String studentId) async {
    final student = await (_localDB.select(_localDB.students)
      ..where((tbl) => tbl.id.equals(studentId)))
        .getSingleOrNull();
    
    if (student == null) {
      // If not in local DB, try fetching from Firebase and store locally
      final firebaseData = await _firebaseDB.streamStudentData(studentId).first;
      if (firebaseData != null) {
        await createStudent(firebaseData);
        return firebaseData;
      }
      return null;
    }
    
    return student.toJson();
  }

  Stream<Map<String, dynamic>?> watchStudent(String studentId) {
    return _firebaseDB.streamStudentData(studentId);
  }
}