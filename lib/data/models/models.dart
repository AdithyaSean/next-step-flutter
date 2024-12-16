import 'package:drift/drift.dart';
import 'dart:convert';

// Type converters
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

@DataClassName("StudentData")
class Students extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get email => text()();
  TextColumn get contact => text().nullable()();
  TextColumn get school => text().nullable()();
  TextColumn get district => text()();
  TextColumn get password => text()();
  TextColumn get olResults => text().map(const MapConverter<String, String>())();
  TextColumn get alResults => text().map(const MapConverter<String, String>())();
  TextColumn get stream => text().nullable()();
  RealColumn get zScore => real().nullable()();
  TextColumn get interests => text().map(const ListConverter<String>())();
  TextColumn get skills => text().map(const ListConverter<String>())();
  TextColumn get strengths => text().map(const ListConverter<String>())();
  TextColumn get predictions => text().map(const MapConverter<String, Map<String, dynamic>>())();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('StreamData')
class Streams extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  TextColumn get requiredOLSubjects => text().map(const ListConverter<String>())();
  TextColumn get minimumOLGrades => text().map(const MapConverter<String, String>())();
  TextColumn get possibleCourses => text().map(const MapConverter<String, String>())();
  TextColumn get relatedCareers => text().map(const ListConverter<String>())();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('CourseData')
class Courses extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  TextColumn get duration => text()();
  TextColumn get streamId => text().references(Streams, #id)();
  TextColumn get minimumALGrades => text().map(const MapConverter<String, String>())();
  RealColumn get minimumZScore => real()();
  TextColumn get offeredByInstitutions => text().map(const ListConverter<String>())();
  TextColumn get relatedCareers => text().map(const ListConverter<String>())();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('CareerData')
class Careers extends Table {
  TextColumn get code => text()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get category => text()();
  TextColumn get requiredSkills => text().map(const ListConverter<String>())();
  TextColumn get relatedCourses => text().map(const ListConverter<String>())();
  TextColumn get externalLinks => text().map(const MapConverter<String, String>())();

  @override
  Set<Column> get primaryKey => {code};
}

@DataClassName('InstitutionData')
class Institutions extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get type => text()();
  TextColumn get website => text()();
  TextColumn get location => text()();
  TextColumn get contactInfo => text().map(const MapConverter<String, String>())();
  TextColumn get courses => text().map(const ListConverter<String>())();

  @override
  Set<Column> get primaryKey => {id};
}
