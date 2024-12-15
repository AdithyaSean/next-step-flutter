import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:drift/native.dart';
import 'dart:convert';
import 'dart:io';

part 'database.g.dart';

// Type converters for complex data types
class MapConverter<K, V> extends TypeConverter<Map<K, V>, String> {
  const MapConverter();

  @override
  Map<K, V> fromSql(String fromDb) => Map<K, V>.from(json.decode(fromDb));

  @override
  String toSql(Map<K, V> value) => json.encode(value);
}

class ListConverter<T> extends TypeConverter<List<T>, String> {
  const ListConverter();

  @override
  List<T> fromSql(String fromDb) => List<T>.from(json.decode(fromDb));

  @override
  String toSql(List<T> value) => json.encode(value);
}

// Table Definitions
class Students extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get email => text()();
  TextColumn get contact => text().nullable()();
  TextColumn get school => text().nullable()();
  TextColumn get district => text()();
  TextColumn get password => text()();
  TextColumn get olResults =>
      text().map(const MapConverter<String, String>())();
  TextColumn get alResults =>
      text().map(const MapConverter<String, String>())();
  TextColumn get stream => text().nullable()();
  RealColumn get zScore => real().nullable()();
  TextColumn get interests => text().map(const ListConverter<String>())();
  TextColumn get skills => text().map(const ListConverter<String>())();
  TextColumn get strengths => text().map(const ListConverter<String>())();
  TextColumn get predictions =>
      text().map(const ListConverter<Map<String, dynamic>>())();

  @override
  Set<Column> get primaryKey => {id};
}

class StudyStreams extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  TextColumn get requiredOLSubjects =>
      text().map(const ListConverter<String>())();
  TextColumn get minimumOLGrades =>
      text().map(const MapConverter<String, String>())();
  TextColumn get possibleCourses =>
      text().map(const ListConverter<Map<String, dynamic>>())();
  TextColumn get relatedCareers => text().map(const ListConverter<String>())();

  @override
  Set<Column> get primaryKey => {id};
}

class Courses extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  TextColumn get duration => text()();
  TextColumn get streamId => text()();
  TextColumn get minimumALGrades =>
      text().map(const MapConverter<String, String>())();
  RealColumn get minimumZScore => real()();
  TextColumn get offeredByInstitutions =>
      text().map(const ListConverter<String>())();
  TextColumn get relatedCareers => text().map(const ListConverter<String>())();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Students, StudyStreams, Courses])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Singleton instance
  static final AppDatabase _instance = AppDatabase._internal();

  AppDatabase._internal() : super(_openConnection());

  static AppDatabase get instance => _instance;

  // Student operations
  Future<Student?> getStudent(String id) =>
      (select(students)..where((t) => t.id.equals(id))).getSingleOrNull();
  Future<void> insertStudent(Student student) => into(students).insert(student);
  Future<void> updateStudent(Student student) =>
      (update(students)..where((t) => t.id.equals(student.id))).write(student);
  Future<void> deleteStudent(String id) =>
      (delete(students)..where((t) => t.id.equals(id))).go();

  // Stream operations
  Future<StudyStream?> getStream(String id) =>
      (select(studyStreams)..where((t) => t.id.equals(id))).getSingleOrNull();
  Future<void> insertStream(StudyStream stream) =>
      into(studyStreams).insert(stream);
  Future<void> updateStream(StudyStream stream) =>
      (update(studyStreams)..where((t) => t.id.equals(stream.id)))
          .write(stream);
  Future<void> deleteStream(String id) =>
      (delete(studyStreams)..where((t) => t.id.equals(id))).go();

  // Course operations
  Future<Course?> getCourse(String id) =>
      (select(courses)..where((t) => t.id.equals(id))).getSingleOrNull();
  Future<void> insertCourse(Course course) => into(courses).insert(course);
  Future<void> updateCourse(Course course) =>
      (update(courses)..where((t) => t.id.equals(course.id))).write(course);
  Future<void> deleteCourse(String id) =>
      (delete(courses)..where((t) => t.id.equals(id))).go();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'nextstep.db'));
    return NativeDatabase(file);
  });
}
