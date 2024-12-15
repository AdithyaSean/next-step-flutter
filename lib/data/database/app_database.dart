import 'dart:io';
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:drift_sqflite/drift_sqflite.dart';
import '../models/models.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
  Students,
  Streams,
  Courses,
  Careers,
  Institutions
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return SqfliteQueryExecutor.inDatabaseFolder(
      path: file.path,
      logStatements: true,
    );
  });
}
