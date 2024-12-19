import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/database/app_database.dart';
import 'package:drift/drift.dart';

class FirebaseDBService {
  final FirebaseFirestore _firestore;
  final AppDatabase _localDB;
  late final List<StreamSubscription> _subscriptions;

  FirebaseDBService(this._localDB)
      : _firestore = FirebaseFirestore.instance,
        _subscriptions = [];

  Future<void> initialize() async {
    // Configure Firestore settings
    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );
    
    // Perform initial sync first
    await _performInitialSync();
    
    // Then initialize listeners
    initializeListeners();
  }

  Future<void> _performInitialSync() async {
    try {
      print('Starting initial sync...');
      
      // Get all collections data
      final studentsSnapshot = await _firestore.collection('students').get();
      print('Found ${studentsSnapshot.docs.length} students');
      
      // Process each document
      for (var doc in studentsSnapshot.docs) {
        final data = doc.data();
        data['id'] = doc.id; // Ensure ID is included
        await _updateLocalStudent(data);
      }
      
      print('Initial sync completed');
    } catch (e) {
      print('Error during initial sync: $e');
      rethrow;
    }
  }

  Future<void> _updateLocalStudent(Map<String, dynamic> data) async {
    try {
      // Create properly formatted data structure
      final formattedData = _formatStudentData(data);
      
      final studentCompanion = StudentsCompanion(
        id: Value(formattedData['id'] as String),
        name: Value(formattedData['name'] as String),
        email: Value(formattedData['email'] as String),
        contact: Value(formattedData['contact'] as String),
        school: Value(formattedData['school'] as String),
        district: Value(formattedData['district'] as String),
        password: Value(formattedData['password'] as String),
        olResults: Value(formattedData['olResults'] as Map<String, String>),
        alResults: Value(formattedData['alResults'] as Map<String, String>),
        stream: Value(formattedData['stream'] as String),
        zScore: Value(formattedData['zScore'] as double),
        interests: Value(formattedData['interests'] as List<String>),
        skills: Value(formattedData['skills'] as List<String>),
        strengths: Value(formattedData['strengths'] as List<String>),
        predictions: Value(_formatPredictions(formattedData['predictions'])),
      );

      await _localDB.into(_localDB.students).insertOnConflictUpdate(studentCompanion);
      print('Successfully updated local student: ${formattedData['id']}');
      
    } catch (e, stackTrace) {
      print('Error updating local student: $e');
      print('Original data: $data');
      print('Stack trace: $stackTrace');
      rethrow;
    }
  }

  Map<String, dynamic> _formatStudentData(Map<String, dynamic> rawData) {
    return {
      'id': rawData['id'] ?? '',
      'name': rawData['name'] ?? '',
      'email': rawData['email'] ?? '',
      'contact': rawData['contact']?.toString() ?? '',
      'school': rawData['school']?.toString() ?? '',
      'district': rawData['district']?.toString() ?? '',
      'password': rawData['password']?.toString() ?? '',
      'olResults': _convertToStringMap(rawData['olResults']),
      'alResults': _convertToStringMap(rawData['alResults']),
      'stream': rawData['stream']?.toString() ?? '',
      'zScore': (rawData['zScore'] as num?)?.toDouble() ?? 0.0,
      'interests': _convertToStringList(rawData['interests']),
      'skills': _convertToStringList(rawData['skills']),
      'strengths': _convertToStringList(rawData['strengths']),
      'predictions': rawData['predictions'] ?? <String, Map<String, dynamic>>{},
    };
  }

  Map<String, String> _convertToStringMap(dynamic data) {
    if (data == null) return {};
    if (data is Map) {
      return Map<String, String>.from(
        data.map((key, value) => MapEntry(key.toString(), value.toString()))
      );
    }
    return {};
  }

  List<String> _convertToStringList(dynamic data) {
    if (data == null) return [];
    if (data is List) {
      return data.map((e) => e.toString()).toList();
    }
    return [];
  }

  Map<String, Map<String, dynamic>> _formatPredictions(dynamic data) {
    if (data == null) return {};
    if (data is Map) {
      return Map<String, Map<String, dynamic>>.from(
        data.map((key, value) {
          if (value is Map) {
            return MapEntry(key.toString(), Map<String, dynamic>.from(value));
          }
          return MapEntry(key.toString(), <String, dynamic>{});
        })
      );
    }
    return {};
  }

  // Initialize real-time listeners
  void initializeListeners() {
    _subscriptions.add(
      _firestore.collection('students').snapshots().listen(_handleStudentsUpdate),
    );
    _subscriptions.add(
      _firestore.collection('streams').snapshots().listen(_handleStreamsUpdate),
    );
    _subscriptions.add(
      _firestore.collection('courses').snapshots().listen(_handleCoursesUpdate),
    );
    _subscriptions.add(
      _firestore.collection('careers').snapshots().listen(_handleCareersUpdate),
    );
    _subscriptions.add(
      _firestore.collection('institutions').snapshots().listen(_handleInstitutionsUpdate),
    );
  }

  // Dispose listeners
  void dispose() {
    for (var sub in _subscriptions) {
      sub.cancel();
    }
  }

  void _handleStudentsUpdate(QuerySnapshot snapshot) {
    for (var change in snapshot.docChanges) {
      final doc = change.doc;
      final data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id; // Ensure ID is included

      switch (change.type) {
        case DocumentChangeType.added:
        case DocumentChangeType.modified:
          _updateLocalStudent(data);
          break;
        case DocumentChangeType.removed:
          _localDB.delete(_localDB.students).where((t) => t.id.equals(doc.id));
          break;
      }
    }
  }

  void _handleStreamsUpdate(QuerySnapshot snapshot) {
    for (var change in snapshot.docChanges) {
      final doc = change.doc;
      final data = doc.data() as Map<String, dynamic>;
      final streamCompanion = StreamsCompanion(
        id: Value(doc.id),
        name: Value(data['name'] as String),
        description: Value(data['description'] as String),
        requiredOLSubjects: Value(data['requiredOLSubjects'] as List<String>),
        minimumOLGrades: Value(data['minimumOLGrades'] as Map<String, String>),
        possibleCourses: Value(data['possibleCourses'] as Map<String, String>),
        relatedCareers: Value(data['relatedCareers'] as List<String>),
      );

      switch (change.type) {
        case DocumentChangeType.added:
        case DocumentChangeType.modified:
          _localDB
              .into(_localDB.streams)
              .insertOnConflictUpdate(streamCompanion);
          break;
        case DocumentChangeType.removed:
          _localDB
              .delete(_localDB.streams)
              .delete(streamCompanion);
          break;
      }
    }
  }

  void _handleCoursesUpdate(QuerySnapshot snapshot) {
    for (var change in snapshot.docChanges) {
      final doc = change.doc;
      final data = doc.data() as Map<String, dynamic>;
      final courseCompanion = CoursesCompanion(
        id: Value(doc.id),
        name: Value(data['name'] as String),
        description: Value(data['description'] as String),
        duration: Value(data['duration'] as String),
        streamId: Value(data['streamId'] as String),
        minimumALGrades: Value(data['minimumALGrades'] as Map<String, String>),
        minimumZScore: Value(data['minimumZScore'] as double),
        offeredByInstitutions: Value(data['offeredByInstitutions'] as List<String>),
        relatedCareers: Value(data['relatedCareers'] as List<String>),
      );

      switch (change.type) {
        case DocumentChangeType.added:
        case DocumentChangeType.modified:
          _localDB
              .into(_localDB.courses)
              .insertOnConflictUpdate(courseCompanion);
          break;
        case DocumentChangeType.removed:
          _localDB
              .delete(_localDB.courses)
              .delete(courseCompanion);
          break;
      }
    }
  }

  void _handleCareersUpdate(QuerySnapshot snapshot) {
    for (var change in snapshot.docChanges) {
      final doc = change.doc;
      final data = doc.data() as Map<String, dynamic>;
      final careerCompanion = CareersCompanion(
        code: Value(doc.id),
        title: Value(data['title'] as String),
        description: Value(data['description'] as String),
        category: Value(data['category'] as String),
        requiredSkills: Value(data['requiredSkills'] as List<String>),
        relatedCourses: Value(data['relatedCourses'] as List<String>),
        externalLinks: Value(data['externalLinks'] as Map<String, String>),
      );

      switch (change.type) {
        case DocumentChangeType.added:
        case DocumentChangeType.modified:
          _localDB
              .into(_localDB.careers)
              .insertOnConflictUpdate(careerCompanion);
          break;
        case DocumentChangeType.removed:
          _localDB
              .delete(_localDB.careers)
              .delete(careerCompanion);
          break;
      }
    }
  }

  void _handleInstitutionsUpdate(QuerySnapshot snapshot) {
    for (var change in snapshot.docChanges) {
      final doc = change.doc;
      final data = doc.data() as Map<String, dynamic>;
      final institutionCompanion = InstitutionsCompanion(
        id: Value(doc.id),
        name: Value(data['name'] as String),
        type: Value(data['type'] as String),
        website: Value(data['website'] as String),
        location: Value(data['location'] as String),
        contactInfo: Value(data['contactInfo'] as Map<String, String>),
        courses: Value(data['courses'] as List<String>),
      );

      switch (change.type) {
        case DocumentChangeType.added:
        case DocumentChangeType.modified:
          _localDB
              .into(_localDB.institutions)
              .insertOnConflictUpdate(institutionCompanion);
          break;
        case DocumentChangeType.removed:
          _localDB
              .delete(_localDB.institutions)
              .delete(institutionCompanion);
          break;
      }
    }
  }

  // Update or create student data
  Future<void> updateStudent(Map<String, dynamic> studentData, String studentId) async {
    try {
      // Format data before saving to Firestore
      final formattedData = _formatStudentData(studentData);
      await _firestore.collection('students').doc(studentId).set(formattedData);
      await _updateLocalStudent(formattedData);
      print('Successfully updated student in both Firestore and local DB: $studentId');
    } catch (e) {
      print('Error updating student: $e');
      rethrow;
    }
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
