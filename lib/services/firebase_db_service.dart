import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/database/app_database.dart';
import 'package:drift/drift.dart';

class FirebaseDBService {
  final FirebaseFirestore _firestore;
  final AppDatabase _localDB;

  FirebaseDBService(this._localDB) : _firestore = FirebaseFirestore.instance;

  // Sync all collections
  Future<void> syncAllData() async {
    await Future.wait([
      syncStudents(),
      syncStreams(),
      syncCourses(),
      syncCareers(),
      syncInstitutions(),
    ]);
  }

  // Students sync
  Future<void> syncStudents() async {
    final snapshot = await _firestore.collection('students').get();
    for (var doc in snapshot.docs) {
      final data = doc.data();
      await _localDB.into(_localDB.students).insertOnConflictUpdate(
        StudentsCompanion.insert(
          id: doc.id,
          name: data['name'] as String,
          email: data['email'] as String,
          contact: Value(data['contact'] as String?),
          school: Value(data['school'] as String?),
          district: data['district'] as String,
          password: data['password'] as String,
          olResults: data['olResults'] as Map<String, String>,
          alResults: data['alResults'] as Map<String, String>,
          stream: Value(data['stream'] as String?),
          zScore: Value(data['zScore'] as double?),
          interests: data['interests'] as List<String>,
          skills: data['skills'] as List<String>,
          strengths: data['strengths'] as List<String>,
          predictions: data['predictions'] as Map<String, Map<String, dynamic>>,
        ),
      );
    }
  }

  // Streams sync
  Future<void> syncStreams() async {
    final snapshot = await _firestore.collection('streams').get();
    for (var doc in snapshot.docs) {
      final data = doc.data();
      await _localDB.into(_localDB.streams).insertOnConflictUpdate(
        StreamsCompanion.insert(
          id: doc.id,
          name: data['name'] as String,
          description: data['description'] as String,
          requiredOLSubjects: data['requiredOLSubjects'] as List<String>,
          minimumOLGrades: data['minimumOLGrades'] as Map<String, String>,
          possibleCourses: data['possibleCourses'] as Map<String, String>,
          relatedCareers: data['relatedCareers'] as List<String>,
        ),
      );
    }
  }

  // Courses sync
  Future<void> syncCourses() async {
    final snapshot = await _firestore.collection('courses').get();
    for (var doc in snapshot.docs) {
      final data = doc.data();
      await _localDB.into(_localDB.courses).insertOnConflictUpdate(
        CoursesCompanion.insert(
          id: doc.id,
          name: data['name'] as String,
          description: data['description'] as String,
          duration: data['duration'] as String,
          streamId: data['streamId'] as String,
          minimumALGrades: data['minimumALGrades'] as Map<String, String>,
          minimumZScore: data['minimumZScore'] as double,
          offeredByInstitutions: data['offeredByInstitutions'] as List<String>,
          relatedCareers: data['relatedCareers'] as List<String>,
        ),
      );
    }
  }

  // Careers sync
  Future<void> syncCareers() async {
    final snapshot = await _firestore.collection('careers').get();
    for (var doc in snapshot.docs) {
      final data = doc.data();
      await _localDB.into(_localDB.careers).insertOnConflictUpdate(
        CareersCompanion.insert(
          code: doc.id,
          title: data['title'] as String,
          description: data['description'] as String,
          category: data['category'] as String,
          requiredSkills: data['requiredSkills'] as List<String>,
          relatedCourses: data['relatedCourses'] as List<String>,
          externalLinks: data['externalLinks'] as Map<String, String>,
        ),
      );
    }
  }

  // Institutions sync
  Future<void> syncInstitutions() async {
    final snapshot = await _firestore.collection('institutions').get();
    for (var doc in snapshot.docs) {
      final data = doc.data();
      await _localDB.into(_localDB.institutions).insertOnConflictUpdate(
        InstitutionsCompanion.insert(
          id: doc.id,
          name: data['name'] as String,
          type: data['type'] as String,
          website: data['website'] as String,
          location: data['location'] as String,
          contactInfo: data['contactInfo'] as Map<String, String>,
          courses: data['courses'] as List<String>,
        ),
      );
    }
  }

  // Update or create student data
  Future<void> updateStudent(Map<String, dynamic> studentData, String studentId) async {
    await _firestore.collection('students').doc(studentId).set(studentData);
    await syncStudents();
  }

  // Stream real-time updates for a student
  Stream<Map<String, dynamic>?> streamStudentData(String studentId) {
    return _firestore
        .collection('students')
        .doc(studentId)
        .snapshots()
        .map((snapshot) => snapshot.data());
  }
}
