import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/student.dart';
import '../services/student_service.dart';

class AuthController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    hostedDomain: '',
    clientId: '',
  );
  final StudentService _studentService = StudentService('http://your-spring-boot-server-url');

  Future<void> signUp({
    required String username,
    required String name,
    required String email,
    required String contact,
    required String school,
    required String district,
    required String password,
  }) async {
    final student = Student(
      id: username,
      name: name,
      email: email,
      contact: contact,
      school: school,
      district: district,
      password: password,
      olResults: {},
      alResults: {},
      stream: 0,
      zScore: 0.0,
      gpa: 0.0,
      interests: [],
      skills: [],
      predictions: [],
      firebaseUid: '',
      firebaseToken: '',
    );

    await _studentService.addStudent(student);
  }

  Future<String> signInWithGoogle() async {
    try {
      print('Starting Google Sign In...');

      await _googleSignIn.signOut();

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        print('User canceled the sign-in');
        return '';
      }

      print('Google Sign In successful, getting auth details...');
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      print('Got credentials, signing in to Firebase...');
      final UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);

      if (userCredential.user == null) {
        throw Exception('Failed to sign in with Google');
      }

      print('Successfully signed in with Google: ${userCredential.user?.uid}');
      await _handleUserAfterSignIn(userCredential.user);
      return userCredential.user!.uid;

    } catch (e, stackTrace) {
      print('Error during Google Sign In: $e');
      print('Stack trace: $stackTrace');
      rethrow;
    }
  }

  Future<void> _handleUserAfterSignIn(User? user) async {
    if (user == null) return;

    try {
      print('Handling user after sign in: ${user.uid}');

      final existingStudent = await _studentService.getStudentById(user.uid);
    } catch (e) {
      print('Error handling user after sign in: $e');
      rethrow;
    }
  }

  Future<bool> isProfileComplete(String userId) async {
    try {
      final student = await _studentService.getStudentById(userId);
      return student.olResults.isNotEmpty &&
          student.district.isNotEmpty &&
          student.interests.isNotEmpty;
    } catch (e) {
      print('Error checking profile completeness: $e');
      return false;
    }
  }

  String? getCurrentUserId() {
    return FirebaseAuth.instance.currentUser?.uid;
  }
}