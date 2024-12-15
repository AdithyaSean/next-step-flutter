import '../models/course.dart';  // Domain model
import '../database/database.dart' as db;  // Drift database
import '../../services/firebase_db_service.dart';

class CourseRepository {
  final db.AppDatabase _localDb;
  final FirebaseDBService _cloudDb;

  CourseRepository(this._localDb, this._cloudDb);

  // Create
  Future<void> createCourse(Course course) async {
    await _localDb.insertCourse(_toDbCourse(course));
    await _cloudDb.syncCourse(course);
  }

  // Read
  Future<Course?> getCourse(String id) async {
    final dbCourse = await _localDb.getCourse(id);
    return dbCourse != null ? _fromDbCourse(dbCourse) : null;
  }

  Stream<List<Course>> watchAllCourses() {
    return _cloudDb.streamCourses();
  }

  // Update
  Future<void> updateCourse(Course course) async {
    await _localDb.updateCourse(_toDbCourse(course));
    await _cloudDb.syncCourse(course);
  }

  // Delete
  Future<void> deleteCourse(Course course) async {
    await _localDb.deleteCourse(course.id);
    await _cloudDb.deleteCourse(course.id);
  }

  // Sync
  Future<void> syncWithCloud() async {
    final cloudCourses = await _cloudDb.streamCourses().first;
    for (final course in cloudCourses) {
      await _localDb.insertCourse(_toDbCourse(course));
    }
  }

  // Conversion helpers
  db.Course _toDbCourse(Course course) => db.Course(
        id: course.id,
        name: course.name,
        description: course.description,
        duration: course.duration,
        streamId: course.streamId,
        minimumALGrades: course.minimumALGrades,
        minimumZScore: course.minimumZScore,
        offeredByInstitutions: course.offeredByInstitutions,
        relatedCareers: course.relatedCareers,
      );

  Course _fromDbCourse(db.Course dbCourse) => Course(
        id: dbCourse.id,
        name: dbCourse.name,
        description: dbCourse.description,
        duration: dbCourse.duration,
        streamId: dbCourse.streamId,
        minimumALGrades: dbCourse.minimumALGrades,
        minimumZScore: dbCourse.minimumZScore,
        offeredByInstitutions: dbCourse.offeredByInstitutions,
        relatedCareers: dbCourse.relatedCareers,
      );
}
