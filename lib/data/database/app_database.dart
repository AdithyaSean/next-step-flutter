import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/foundation.dart' show kIsWeb;
import '../models/models.dart';
import '../../services/firebase_db_service.dart';
import '../repositories/student_repository.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [Students, Streams, Courses, Careers, Institutions],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Add migration logic here when needed
      },
      beforeOpen: (details) async {
        final dbPath = await _getDatabasePath();
        print('Database location: $dbPath');
      },
    );
  }

  static Future<String> _getDatabasePath() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'next_step.db'));
    return file.path;
  }

  Future<void> updateStudent(StudentData student) async {
    await update(students).replace(student);
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'next_step.db'));
    
    if (!await file.parent.exists()) {
      await file.parent.create(recursive: true);
    }

    return NativeDatabase.createInBackground(
      file,
      setup: (db) {
        db.execute('PRAGMA foreign_keys = ON');
      },
    );
  });
}

final appDatabase = kIsWeb ? null : AppDatabase();
final firebaseDBService = FirebaseDBService(appDatabase);
final studentRepository = StudentRepository(appDatabase, firebaseDBService);
