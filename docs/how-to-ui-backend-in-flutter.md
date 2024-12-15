# Next Step - Flutter Database Implementation Guide

This guide covers the implementation of local and cloud database solutions for the Next Step application, supporting Phase 2 and 3 of the development roadmap.

## Local Database Implementation

### Setup Dependencies
### Easier Methods for Database Management in Flutter

1. **Using drift:**
   `drift` is a powerful library for using SQLite in Flutter. It provides a more ORM-like experience with type safety and reactive streams.

   **Add Dependencies:**
   dependencies:
     drift
     drift_flutter
     path_provider
     sqflite

   dev_dependencies:
     drift_dev
     build_runner

   **Define the Data Model:**
   [data-model](data-model-flutter.md)
   
   **Set Up the Database:**
   ```dart
   import 'package:drift/drift.dart';
   import 'package:drift_flutter/drift_flutter.dart';
   import 'student.dart';

   part 'database.g.dart';

   @DriftDatabase(tables: [Students, CareerPredictions])
   class AppDatabase extends _$AppDatabase {
     AppDatabase() : super(FlutterQueryExecutor.inDatabaseFolder(path: 'db.sqlite'));

     @override
     int get schemaVersion => 1;

     Future<List<Student>> getAllStudents() => select(students).get();
     Future<void> insertStudent(Student student) => into(students).insert(student);
   }
   ```

   **Generate the Code:**
   Run the build runner to generate the necessary code:
   ```bash
   flutter pub run build_runner build
   ```

   **Use the Database:**
   ```dart
   import 'package:flutter/material.dart';
   import 'database.dart';

   void main() {
     runApp(MyApp());
   }

   class MyApp extends StatelessWidget {
     @override
     Widget build(BuildContext context) {
       return MaterialApp(
         home: Scaffold(
           appBar: AppBar(title: Text('Students')),
           body: StudentList(),
         ),
       );
     }
   }

   class StudentList extends StatefulWidget {
     @override
     _StudentListState createState() => _StudentListState();
   }

   class _StudentListState extends State<StudentList> {
     final AppDatabase db = AppDatabase();

     @override
     Widget build(BuildContext context) {
       return FutureBuilder<List<Student>>(
         future: db.getAllStudents(),
         builder: (context, snapshot) {
           if (snapshot.connectionState == ConnectionState.waiting) {
             return CircularProgressIndicator();
           } else if (snapshot.hasError) {
             return Text('Error: ${snapshot.error}');
           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
             return Text('No data');
           } else {
             final students = snapshot.data!;
             return ListView.builder(
               itemCount: students.length,
               itemBuilder: (context, index) {
                 final student = students[index];
                 return ListTile(
                   title: Text(student.name),
                   subtitle: Text(student.email),
                 );
               },
             );
           }
         },
       );
     }
   }
   ```

## Cloud Database Integration with Firebase

1. **Setup Firebase:**
   First, initialize Firebase in your project:
   ```bash
   flutter pub add firebase_core firebase_database
   flutterfire configure
   ```

2. **Initialize Firebase:**
   ```dart
   void main() async {
     WidgetsFlutterBinding.ensureInitialized();
     await Firebase.initializeApp();
     runApp(MyApp());
   }
   ```

3. **Create Firebase Database Service:**
   ```dart
   class FirebaseDBService {
     final DatabaseReference _database = FirebaseDatabase.instance.ref();

     Future<void> addStudent(Student student) async {
       await _database.child('students').child(student.id).set(student.toJson());
     }

     Future<List<Student>> getAllStudents() async {
       final snapshot = await _database.child('students').get();
       if (snapshot.exists) {
         return (snapshot.value as Map)
             .values
             .map((e) => Student.fromJson(Map<String, dynamic>.from(e)))
             .toList();
       }
       return [];
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

     Future<void> updateStudent(String id, Map<String, dynamic> updates) async {
       await _database.child('students').child(id).update(updates);
     }

     Future<void> deleteStudent(String id) async {
       await _database.child('students').child(id).remove();
     }
   }
   ```

4. **Update Widget to Use Firebase:**
   ```dart
   class StudentList extends StatefulWidget {
     @override
     _StudentListState createState() => _StudentListState();
   }

   class _StudentListState extends State<StudentList> {
     final FirebaseDBService _dbService = FirebaseDBService();

     @override
     Widget build(BuildContext context) {
       return StreamBuilder<List<Student>>(
         stream: _dbService.streamStudents(),
         builder: (context, snapshot) {
           if (snapshot.connectionState == ConnectionState.waiting) {
             return const Center(child: CircularProgressIndicator());
           }
           if (snapshot.hasError) {
             return Center(child: Text('Error: ${snapshot.error}'));
           }
           final students = snapshot.data ?? [];
           return ListView.builder(
             itemCount: students.length,
             itemBuilder: (context, index) {
               final student = students[index];
               return ListTile(
                 title: Text(student.name),
                 subtitle: Text(student.email),
                 trailing: IconButton(
                   icon: const Icon(Icons.delete),
                   onPressed: () => _dbService.deleteStudent(student.id),
                 ),
               );
             },
           );
         },
       );
     }
   }
   ```

5. **Security Rules:**
   In Firebase Console, set up your Realtime Database rules:
   ```json
   {
     "rules": {
       "students": {
         ".read": "auth != null",
         ".write": "auth != null"
       }
     }
   }
   ```

## Hybrid Approach
For optimal performance and offline capability, consider using both local and cloud databases:
1. Store data locally using drift
2. Sync with Firebase when online
3. Use Firebase Authentication for secure access

Remember to:
- Handle offline/online states
- Implement proper error handling
- Set up appropriate Firebase security rules
- Consider implementing data pagination for large datasets

## Summary
1. **Add Dependencies:** Add `drift`, `drift_flutter`, `path_provider`, and `sqflite` to your 

pubspec.yaml

.
2. **Define the Data Model:** Create `Student` and `CareerPrediction` classes with converters for complex types.
3. **Set Up the Database:** Create an `AppDatabase` class to manage database operations.
4. **Generate the Code:** Use `build_runner` to generate the necessary code.
5. **Use the Database:** Use the `AppDatabase` class in your Flutter app to perform CRUD operations.

Using `drift` (formerly `moor`) provides a more ORM-like experience in Flutter, making it easier to manage local databases with type safety and reactive streams. Adjust the code to fit your specific requirements and project structure.
