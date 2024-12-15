import '../models/student.dart';  // Domain model
import '../database/database.dart' as db;  // Drift database
import '../../services/firebase_db_service.dart';

class StudentRepository {
  final db.AppDatabase _localDb;
  final FirebaseDBService _cloudDb;

  StudentRepository(this._localDb, this._cloudDb);

  // Create
  Future<void> createStudent(Student student) async {
    await _localDb.insertStudent(_toDbStudent(student)); // Convert to DB model
    await _cloudDb.syncStudent(student); // Use domain model
  }

  // Read
  Future<Student?> getStudent(String id) async {
    final dbStudent = await _localDb.getStudent(id);
    return dbStudent != null ? _fromDbStudent(dbStudent) : null;
  }

  Stream<List<Student>> watchAllStudents() {
    return _cloudDb.streamStudents();
  }

  // Update
  Future<void> updateStudent(Student student) async {
    await _localDb.updateStudent(_toDbStudent(student));
    await _cloudDb.syncStudent(student);
  }

  // Delete
  Future<void> deleteStudent(Student student) async {
    await _localDb.deleteStudent(student.id);
    await _cloudDb.deleteStudent(student.id);
  }

  // Sync
  Future<void> syncWithCloud() async {
    final cloudStudents = await _cloudDb.streamStudents().first;
    for (final student in cloudStudents) {
      await _localDb.insertStudent(_toDbStudent(student));  // Fixed type mismatch
    }
  }

  // Conversion helpers
  db.Student _toDbStudent(Student student) => db.Student(
    id: student.id,
    name: student.name,
    email: student.email,
    contact: student.contact,
    school: student.school,
    district: student.district,
    password: student.password,
    olResults: student.olResults,
    alResults: student.alResults,
    stream: student.stream,
    zScore: student.zScore,
    interests: student.interests,
    skills: student.skills,
    strengths: student.strengths,
    predictions: student.predictions.map((p) => p.toJson()).toList(),
  );

  Student _fromDbStudent(db.Student dbStudent) => Student(
        id: dbStudent.id,
        name: dbStudent.name,
        email: dbStudent.email,
        contact: dbStudent.contact,
        school: dbStudent.school,
        district: dbStudent.district,
        password: dbStudent.password,
        olResults: dbStudent.olResults,
        alResults: dbStudent.alResults,
        stream: dbStudent.stream,
        zScore: dbStudent.zScore,
        interests: dbStudent.interests,
        skills: dbStudent.skills,
        strengths: dbStudent.strengths,
        predictions: dbStudent.predictions.map((json) => 
            CareerPrediction.fromJson(Map<String, dynamic>.from(json))).toList(),
      );
}
