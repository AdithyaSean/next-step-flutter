import 'package:firebase_database/firebase_database.dart';
import '../data/models/student.dart';
import '../data/models/stream.dart';
import '../data/models/course.dart';

class FirebaseDBService {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  // Student methods
  Future<void> syncStudent(Student student) async {
    try {
      await _database.child('students').child(student.id).set(student.toJson());
    } catch (e) {
      print('Error syncing student: $e');
      rethrow;
    }
  }

  Stream<List<Student>> streamStudents() {
    return _database.child('students').onValue.map((event) {
      if (event.snapshot.value == null) return [];
      final data = Map<String, dynamic>.from(event.snapshot.value as Map);
      return data.values
          .map((e) => Student.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    });
  }

  Future<void> deleteStudent(String id) async {
    try {
      await _database.child('students').child(id).remove();
    } catch (e) {
      print('Error deleting student: $e');
      rethrow;
    }
  }

  // Stream methods
  Future<void> syncStream(StudyStream stream) async {
    try {
      await _database.child('streams').child(stream.id).set(stream.toJson());
    } catch (e) {
      print('Error syncing stream: $e');
      rethrow;
    }
  }

  Stream<List<StudyStream>> streamStreams() {
    return _database.child('streams').onValue.map((event) {
      if (event.snapshot.value == null) return [];
      final data = Map<String, dynamic>.from(event.snapshot.value as Map);
      return data.values
          .map((e) => StudyStream.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    });
  }

  Future<void> deleteStream(String id) async {
    try {
      await _database.child('streams').child(id).remove();
    } catch (e) {
      print('Error deleting stream: $e');
      rethrow;
    }
  }

  // Course methods
  Future<void> syncCourse(Course course) async {
    try {
      await _database.child('courses').child(course.id).set(course.toJson());
    } catch (e) {
      print('Error syncing course: $e');
      rethrow;
    }
  }

  Stream<List<Course>> streamCourses() {
    return _database.child('courses').onValue.map((event) {
      if (event.snapshot.value == null) return [];
      final data = Map<String, dynamic>.from(event.snapshot.value as Map);
      return data.values
          .map((e) => Course.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    });
  }

  Future<void> deleteCourse(String id) async {
    try {
      await _database.child('courses').child(id).remove();
    } catch (e) {
      print('Error deleting course: $e');
      rethrow;
    }
  }
}