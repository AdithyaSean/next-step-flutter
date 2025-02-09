import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:next_step/services/auth_service.dart';
import 'package:next_step/services/student_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../mocks.mocks.dart';

void main() {
  group('AuthService Tests', () {
    late AuthService authService;
    late AuthService realAuthService;
    late MockClient mockClient;
    late http.Client realClient;
    const baseUrl = 'http://localhost:8080';
    
    // Test data
    const testUuid = '550e8400-e29b-41d4-a716-446655440000';
    const testUsername = 'student1';
    const testPassword = 'pass123';

    Map<String, String> signUpRequest = {
      'username': testUsername,
      'name': 'John Student',
      'email': 'student1@example.com',
      'password': testPassword,
      'telephone': '1234567890',
      'role': 'STUDENT',
      'school': 'Central School',
      'district': 'Western',
    };

    Map<String, dynamic> signUpResponse = {
      'id': testUuid,
      'username': testUsername,
      'name': 'John Student',
      'email': 'student1@example.com',
      'telephone': '1234567890',
      'role': 'STUDENT',
      'school': 'Central School',
      'district': 'Western',
      'active': true,
      'createdAt': DateTime.now().toIso8601String(),
      'updatedAt': DateTime.now().toIso8601String(),
    };

    final loginResponse = signUpResponse;

    final Map<String, double> olResults = {
      'Maths': 85.0,
      'Science': 82.0,
      'English': 78.0,
      'Sinhala': 80.0,
      'History': 75.0,
      'Religion': 88.0,
    };

    final olProfileResponse = {
      'id': testUuid,
      'educationLevel': 0,
      'olResults': olResults,
    };

    final alProfileResponse = {
      'id': testUuid,
      'educationLevel': 1,
      'olResults': olResults,
      'alStream': 6,
      'alResults': {
        'Physics': 88.0,
        'Chemistry': 85.0,
        'Combined_Maths': 90.0,
      },
      'careerProbabilities': {},
    };

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      mockClient = MockClient();
      realClient = http.Client();
      authService = AuthService(mockClient, isTest: true);
      realAuthService = AuthService(realClient, isTest: true);
      Get.testMode = true;
      
      // Initialize services for testing
      final studentService = StudentService();
      Get.put<StudentService>(studentService);
      Get.put<http.Client>(mockClient);
      Get.put<AuthService>(authService);
    });

    tearDown(() {
      realClient.close();
      Get.reset();
      Get.deleteAll();
    });

    test('Sign Up - Success Flow', () async {
      // Mock POST requests
      when(mockClient.post(
        Uri.parse('$baseUrl/students'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(signUpRequest),
      )).thenAnswer((_) async => http.Response(json.encode(signUpResponse), 201));

      when(mockClient.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': testUsername,
          'password': testPassword,
        }),
      )).thenAnswer((_) async => http.Response(json.encode(loginResponse), 200));

      // Mock GET request
      when(mockClient.get(
        Uri.parse('$baseUrl/students/profile'),
        headers: {
          'Content-Type': 'application/json',
          'UUID': testUuid,
        },
      )).thenAnswer((_) async => http.Response('Not Found', 404));

      // Perform signup
      final user = await authService.signUp(
        username: testUsername,
        password: testPassword,
        name: 'John Student',
        email: 'student1@example.com',
        telephone: '1234567890',
        school: 'Central School',
        district: 'Western',
      );

      // Verify response
      expect(user.id, equals(testUuid));
      expect(user.username, equals(testUsername));
      expect(user.role, equals('STUDENT'));

      // Verify stored credentials
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString(AuthService.uuidKey), equals(testUuid));
    });

    test('Sign Out - Clear Credentials', () async {
      // Set initial state
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(AuthService.uuidKey, testUuid);

      // Mock responses
      when(mockClient.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': testUsername,
          'password': testPassword,
        }),
      )).thenAnswer((_) async => http.Response(json.encode(loginResponse), 200));

      when(mockClient.get(
        Uri.parse('$baseUrl/students/profile'),
        headers: {
          'Content-Type': 'application/json',
          'UUID': testUuid,
        },
      )).thenAnswer((_) async => http.Response(json.encode(olProfileResponse), 200));

      // Sign in
      await authService.signIn(testUsername, testPassword);

      // Verify logged in state
      expect(await authService.isLoggedIn(), isTrue);
      expect(await authService.getCurrentUserId(), equals(testUuid));

      // Sign out
      await authService.signOut();

      // Verify logged out state
      expect(await authService.isLoggedIn(), isFalse);
      expect(await authService.getCurrentUserId(), isNull);
      expect(prefs.getString(AuthService.uuidKey), isNull);
    });

    test('Sign Up - Handle Duplicate Email', () async {
      final existingEmail = 'adithya5@gmail.com';
      final newEmail = 'adithya${DateTime.now().millisecondsSinceEpoch}@gmail.com';
      
      // First attempt with existing email
      final firstAttemptBody = json.encode({
        'username': 'testuser1',
        'name': 'Test User',
        'email': existingEmail,
        'password': 'password123',
        'telephone': '1234567890',
        'role': 'STUDENT',
        'school': 'Test School',
        'district': 'Test District',
      });

      when(mockClient.post(
        Uri.parse('$baseUrl/students'),
        headers: {'Content-Type': 'application/json'},
        body: firstAttemptBody,
      )).thenAnswer((_) async => http.Response(json.encode({
        "timestamp": "2025-02-07T18:29:54.226+00:00",
        "status": 500,
        "error": "Internal Server Error",
        "message": "could not execute statement [ERROR: duplicate key value violates unique constraint \"uk6dotkott2kjsp8vw4d0m25fb7\" Detail: Key (email)=($existingEmail) already exists.]"
      }), 500));

      try {
        await authService.signUp(
          username: 'testuser1',
          password: 'password123',
          name: 'Test User',
          email: existingEmail,
          telephone: '1234567890',
          school: 'Test School',
          district: 'Test District',
        );
        fail('Should throw exception for duplicate email');
      } catch (e) {
        expect(e.toString().toLowerCase(), contains('duplicate'));
        expect(e.toString().toLowerCase(), contains('email'));
      }

      // Second attempt with new email should succeed
      final secondAttemptBody = json.encode({
        'username': 'testuser1',
        'name': 'Test User',
        'email': newEmail,
        'password': 'password123',
        'telephone': '1234567890',
        'role': 'STUDENT',
        'school': 'Test School',
        'district': 'Test District',
      });

      when(mockClient.post(
        Uri.parse('$baseUrl/students'),
        headers: {'Content-Type': 'application/json'},
        body: secondAttemptBody,
      )).thenAnswer((_) async => http.Response(json.encode({
        'id': testUuid,
        'username': 'testuser1',
        'name': 'Test User',
        'email': newEmail,
        'telephone': '1234567890',
        'role': 'STUDENT',
        'school': 'Test School',
        'district': 'Test District',
        'active': true,
        'createdAt': DateTime.now().toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
      }), 201));

      final user = await authService.signUp(
        username: 'testuser1',
        password: 'password123',
        name: 'Test User',
        email: newEmail,
        telephone: '1234567890',
        school: 'Test School',
        district: 'Test District',
      );

      expect(user, isNotNull);
      expect(user.id, equals(testUuid));
      expect(user.email, equals(newEmail));

      // Verify UUID was saved
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString(AuthService.uuidKey), equals(testUuid));
    });

    test('Sign In - Real Server Connection Test', () async {
      try {
        await realAuthService.signIn('test', 'test');
        fail('Should throw exception when server is down');
      } catch (e) {
        final error = e.toString().toLowerCase();
        expect(error.contains('connection') || error.contains('unable to connect'), true);
      }
    });

    test('Sign Up - Real Server Connection Test', () async {
      try {
        await realAuthService.signUp(
          username: 'testuser',
          password: 'password',
          name: 'Test User',
          email: 'test@example.com',
          telephone: '1234567890',
          school: 'Test School',
          district: 'Test District',
        );
        fail('Should throw exception when server is down');
      } catch (e) {
        final error = e.toString().toLowerCase();
        expect(error.contains('connection') || error.contains('unable to connect'), true);
      }
    });

    test('Get Profile - Real Server Connection Test', () async {
      final profile = await realAuthService.getUserProfile('test-uuid');
      expect(profile, isNull);
    });

    test('Sign In - With AL Profile', () async {
      when(mockClient.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': testUsername,
          'password': testPassword,
        }),
      )).thenAnswer((_) async => http.Response(json.encode(loginResponse), 200));

      when(mockClient.get(
        Uri.parse('$baseUrl/students/profile'),
        headers: {
          'Content-Type': 'application/json',
          'UUID': testUuid,
        },
      )).thenAnswer((_) async => http.Response(json.encode(alProfileResponse), 200));

      final user = await authService.signIn(testUsername, testPassword);
      expect(user, isNotNull);
      expect(user!.id, equals(testUuid));
      expect(user.username, equals(testUsername));
      expect(user.educationLevel, equals(1));
      expect(user.olResults, equals(olResults));
      expect(user.alStream, equals(6));
      expect(user.alResults, equals({
        'Physics': 88.0,
        'Chemistry': 85.0,
        'Combined_Maths': 90.0,
      }));
    });
  });
}
