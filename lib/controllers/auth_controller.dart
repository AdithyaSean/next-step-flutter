import 'package:get/get.dart';
import '../services/auth_service.dart';

class AuthController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  final RxBool isLoading = false.obs;
  final RxBool isAuthenticated = false.obs;
  final RxMap<String, dynamic> currentUser = RxMap<String, dynamic>();

  @override
  void onInit() async {
    super.onInit();
    await checkAuthentication();
  }

  Future<void> checkAuthentication() async {
    isLoading.value = true;
    isAuthenticated.value = await _authService.isAuthenticated();
    if (isAuthenticated.value) {
      await loadUserProfile();
    }
    isLoading.value = false;
  }

  Future<void> loadUserProfile() async {
    try {
      final user = await _authService.getUserProfile();
      currentUser.value = user;
    } catch (e) {
      isAuthenticated.value = false;
      currentUser.value = {};
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      isLoading.value = true;
      await _authService.signOut();
      isAuthenticated.value = false;
      currentUser.value = {};
      Get.offAllNamed('/login');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshSession() async {
    try {
      isLoading.value = true;
      await _authService.refreshToken();
      await loadUserProfile();
    } catch (e) {
      isAuthenticated.value = false;
      currentUser.value = {};
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
