import 'dart:async';
import '../models/stream.dart';
import '../models/course.dart';  // Add this import
import '../database/database.dart' as db;
import '../../services/firebase_db_service.dart';

class StreamRepository {
  final db.AppDatabase _localDb;
  final FirebaseDBService _cloudDb;

  StreamRepository(this._localDb, this._cloudDb);

  // Create
  Future<void> createStream(StudyStream stream) async {
    await _localDb.insertStream(_toDbStream(stream));
    await _cloudDb.syncStream(stream);
  }

  // Read
  Future<StudyStream?> getStream(String id) async {
    final dbStream = await _localDb.getStream(id);
    return dbStream != null ? _fromDbStream(dbStream) : null;
  }

  Stream<List<StudyStream>> watchAllStreams() {
    return _cloudDb.streamStreams();
  }

  // Update
  Future<void> updateStream(StudyStream stream) async {
    await _localDb.updateStream(_toDbStream(stream));
    await _cloudDb.syncStream(stream);
  }

  // Delete
  Future<void> deleteStream(StudyStream stream) async {
    await _localDb.deleteStream(stream.id);
    await _cloudDb.deleteStream(stream.id);
  }

  // Sync
  Future<void> syncWithCloud() async {
    final cloudStreams = await _cloudDb.streamStreams().first;
    for (final stream in cloudStreams) {
      await _localDb.insertStream(_toDbStream(stream));
    }
  }

  // Conversion helpers
  db.StudyStream _toDbStream(StudyStream stream) => db.StudyStream(
        id: stream.id,
        name: stream.name,
        description: stream.description,
        requiredOLSubjects: stream.requiredOLSubjects,
        minimumOLGrades: stream.minimumOLGrades,
        possibleCourses: stream.possibleCourses.map((c) => c.toJson()).toList(),
        relatedCareers: stream.relatedCareers,
      );

  StudyStream _fromDbStream(db.StudyStream dbStream) => StudyStream(
        id: dbStream.id,
        name: dbStream.name,
        description: dbStream.description,
        requiredOLSubjects: dbStream.requiredOLSubjects,
        minimumOLGrades: dbStream.minimumOLGrades,
        possibleCourses: dbStream.possibleCourses
            .map((c) => Course.fromJson(Map<String, dynamic>.from(c)))
            .toList(),
        relatedCareers: dbStream.relatedCareers,
      );
}