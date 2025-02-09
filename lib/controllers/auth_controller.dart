import 'package:get/get.dart';
import 'package:next_step/models/user.dart';
import 'package:next_step/services/auth_service.dart';

class AuthController extends GetxController {
  final AuthService _authService;
  final user = Rx<User?>(null);
  final loading = false.obs;

  // Getters for UI widgets
  User? get currentUser => user.value;
  bool get isLoading => loading.value;

  // Consider user authenticated only if they have a valid profile
  bool get isAuthenticated {
    if (user.value == null) return false;

    switch (user.value!.educationLevel) {
      case 0: // OL
        return user.value!.olResults.isNotEmpty;
      case 1: // AL
        return user.value!.olResults.isNotEmpty &&
            user.value!.alResults.isNotEmpty;
      case 2: // University
        return user.value!.olResults.isNotEmpty &&
            user.value!.alResults.isNotEmpty &&
            user.value!.gpa != 0.0;
      default:
        return false;
    }
  }

  AuthController({required AuthService authService})
      : _authService = authService;

  @override
  void onInit() {
    super.onInit();
    ever(user, (_) => _checkProfile());
    initialize();
  }

  Future<void> initialize() async {
    await initializeUser();
  }

  Future<void> initializeUser() async {
    loading.value = true;
    try {
      await _authService.initAsync();
      await refreshUserProfile();
    } finally {
      loading.value = false;
    }
  }

  void _checkProfile() {
    if (user.value == null) return;

    // If they have a complete profile, take them to home
    if (isAuthenticated) {
      Get.offAllNamed('/home');
      return;
    }

    // Otherwise direct them to edit profile
    switch (user.value!.educationLevel) {
      case 0:
        if (user.value!.olResults.isEmpty) {
          Get.offAllNamed('/profile/edit');
        }
        break;
      case 1:
        if (user.value!.olResults.isEmpty || user.value!.alResults.isEmpty) {
          Get.offAllNamed('/profile/edit');
        }
        break;
      case 2:
        if (user.value!.olResults.isEmpty ||
            user.value!.alResults.isEmpty ||
            user.value!.gpa == 0.0) {
          Get.offAllNamed('/profile/edit');
        }
        break;
    }
  }

  Future<void> refreshUserProfile() async {
    loading.value = true;
    try {
      final currentUser = await _authService.getUserProfile();
      user.value = currentUser;
    } finally {
      loading.value = false;
    }
  }

  Future<void> signIn(String username, String password) async {
    loading.value = true;
    try {
      user.value = await _authService.signIn(username, password);
    } finally {
      loading.value = false;
    }
  }

  Future<void> signUp({
    required String username,
    required String password,
    required String name,
    required String email,
    required String telephone,
    required String school,
    required String district,
  }) async {
    loading.value = true;
    try {
      user.value = await _authService.signUp(
        username: username,
        password: password,
        name: name,
        email: email,
        telephone: telephone,
        school: school,
        district: district,
      );
    } finally {
      loading.value = false;
    }
  }

  Future<void> signOut() async {
    loading.value = true;
    try {
      await _authService.signOut();
      user.value = null;
    } finally {
      loading.value = false;
    }
  }

  Future<void> updateProfile({
    required int educationLevel,
    required Map<String, double> olResults,
    int? alStream,
    Map<String, double>? alResults,
    double? gpa,
  }) async {
    loading.value = true;
    try {
      if (user.value == null) throw Exception('No user logged in');

      final updatedUser = await _authService.updateProfile(
        user.value!.id,
        educationLevel: educationLevel,
        olResults: olResults,
        alStream: alStream,
        alResults: alResults,
        gpa: gpa,
      );

      user.value = updatedUser;
    } finally {
      loading.value = false;
    }
  }
}
