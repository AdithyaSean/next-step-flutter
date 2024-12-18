import '../database/app_database.dart';
import '../../services/firebase_db_service.dart';

class StudentRepository {
  final AppDatabase _localDB;
  final FirebaseDBService _firebaseDB;

  StudentRepository(this._localDB, this._firebaseDB);

  Future<void> createStudent(Map<String, dynamic> studentData) async {
    final studentId = studentData['id'];
    await _firebaseDB.updateStudent(studentData, studentId);
    // Local database will update automatically via listeners
  }

  Future<Map<String, dynamic>?> getStudent(String studentId) async {
    final student = await (_localDB.select(_localDB.students)
      ..where((tbl) => tbl.id.equals(studentId)))
        .getSingleOrNull();

    return student?.toJson();
  }

  Stream<Map<String, dynamic>?> watchStudent(String studentId) {
    return _firebaseDB.streamStudentData(studentId);
  }

  Future<void> updateStudent(StudentData student) async {
    await _localDB.updateStudent(student);
  }
}