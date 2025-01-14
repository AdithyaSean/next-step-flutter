import '../database/app_database.dart';
import '../../services/firebase_db_service.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class StudentRepository {
  final AppDatabase? _localDB; // Nullable for web
  final FirebaseDBService _firebaseDB;

  StudentRepository(this._localDB, this._firebaseDB);

  Future<void> createStudent(Map<String, dynamic> studentData) async {
    final studentId = studentData['id'];
    await _firebaseDB.updateStudent(studentData, studentId);

    // Only update local database if not on the web
    if (!kIsWeb && _localDB != null) {
    // Local database will update automatically via listeners
  }
  }

  Future<Map<String, dynamic>?> getStudent(String studentId) async {
    if (!kIsWeb && _localDB != null) {
    final student = await (_localDB.select(_localDB.students)
      ..where((tbl) => tbl.id.equals(studentId)))
        .getSingleOrNull();
    return student?.toJson();
    } else {
      // Fallback to Firebase if on the web or localDB is null
      final snapshot = await _firebaseDB.streamStudentData(studentId).first;
      return snapshot;
  }
  }

  Stream<Map<String, dynamic>?> watchStudent(String studentId) {
    return _firebaseDB.streamStudentData(studentId);
  }

  Future<void> updateStudent(StudentData student) async {
    if (!kIsWeb && _localDB != null) {
      await _localDB.updateStudent(student);
}
  }
}
