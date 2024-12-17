import '../data/repositories/student_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController {
  final StudentRepository _studentRepository;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    hostedDomain: '', // Set to empty string to allow any domain
    clientId: '', // Optional: Add your client ID here if needed
  );
  
  AuthController(this._studentRepository);

  Future<void> signUp({
    required String username,
    required String name,
    required String email,
    required String contact,
    required String school,
    required String district,
    required String password,
  }) async {
    final studentData = {
      'id': username,
      'name': name,
      'email': email,
      'contact': contact,
      'school': school,
      'district': district,
      'password': password,
      'olResults': <String, String>{},
      'alResults': <String, String>{},
      'stream': '',
      'zScore': 0.0,
      'interests': <String>[],
      'skills': <String>[],
      'strengths': <String>[],
      'predictions': <String, Map<String, dynamic>>{},
    };

    await _studentRepository.createStudent(studentData);
  }

  Future<String> signInWithGoogle() async {
    try {
      print('Starting Google Sign In...');
      
      // Sign out first to ensure clean state
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
      
      // Check if student exists in local database
      final existingStudent = await _studentRepository.getStudent(user.uid);
      if (existingStudent == null) {
        // Create student data
        final studentData = {
          'id': user.uid,
          'name': user.displayName ?? '',
          'email': user.email ?? '',
          // Add default or empty values for other required fields
          'contact': '',
          'school': '',
          'district': '',
          'password': '', // Consider handling passwords securely
          'olResults': <String, String>{},
          'alResults': <String, String>{},
          'stream': '',
          'zScore': 0.0,
          'interests': <String>[],
          'skills': <String>[],
          'strengths': <String>[],
          'predictions': <String, Map<String, dynamic>>{},
        };

        await _studentRepository.createStudent(studentData);
        print('Successfully created/updated student data');
      }
    } catch (e) {
      print('Error handling user after sign in: $e');
      rethrow;
    }
  }

  Future<bool> isProfileComplete(String userId) async {
    final student = await _studentRepository.getStudent(userId);
    if (student == null) return false;
    
    // Check if essential profile data exists
    return student['olResults'] != null && 
           student['olResults'].isNotEmpty &&
           student['district'] != null &&
           student['interests'] != null &&
           student['interests'].isNotEmpty;
  }

  String? getCurrentUserId() {
    return FirebaseAuth.instance.currentUser?.uid;
  }
}