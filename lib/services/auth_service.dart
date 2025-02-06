import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../screens/edit_profile.dart';
import '../screens/home.dart';


class AuthService extends GetxService {
    String? _currentUserId;
  final _isLoggedIn = false.obs;
  static const String uuidKey = 'uuid';

  @override
  void onInit() {
    super.onInit();
    initAsync(); // Don't await here, but start the initialization
  }

  @override
  void onReady() {
    super.onReady();
    // Additional setup after the widget is rendered if needed
  }

  Future<void> initAsync() async {
    try {
      final userProfile = await getUserProfile();
      _isLoggedIn.value = userProfile != null;
      if (userProfile != null) {
        _currentUserId = userProfile.id;
      }
    } catch (e) {
      debugPrint('${Get.currentRoute} - AuthService initialization error: $e');
      _isLoggedIn.value = false;
      _currentUserId = null;
    }
  }

  Future<User?> signIn(String username, String password) async {
    debugPrint('${Get.currentRoute} - signIn called with username: $username, password: $password');
    try {
      final response = await http.post(
        Uri.parse('http://localhost:8080/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      debugPrint('${Get.currentRoute} - signIn response status code: ${response.statusCode}');
      if (response.statusCode == 200) {
        final userJson = jsonDecode(response.body);
        final user = User.fromJson(userJson);

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(uuidKey, user.id);
        await prefs.setString('user', jsonEncode(user.toJson()));

        _currentUserId = user.id;
        _isLoggedIn.value = true;

        debugPrint('${Get.currentRoute} - UUID saved: ${user.id}');

        // Debug: Log user object before isProfileComplete check
        debugPrint('${Get.currentRoute} - signIn user object before isProfileComplete check: ${user.toJson()}');

        // Check if the profile is complete using the new method
        debugPrint('${Get.currentRoute} - signIn isProfileComplete: ${user.isProfileComplete()}');
        if (!user.isProfileComplete()) {
          debugPrint('${Get.currentRoute} - signIn navigating to EditProfileScreen');
          Get.offAll(() => EditProfileScreen(initialProfile: user));
        } else {
          debugPrint('${Get.currentRoute} - signIn navigating to HomeScreen');
          Get.offAll(() => const HomeScreen());
        }

        return user;
      } else {
        debugPrint('${Get.currentRoute} - signIn failed: ${response.body}'); // Log error response
        throw Exception('Failed to sign in: ${response.body}');
      }
    } catch (e) {
      _isLoggedIn.value = false;
      debugPrint('${Get.currentRoute} - signIn exception: $e'); // Log exceptions
      throw Exception('Failed to sign in: $e');
    }
  }

  Future<User?> getUserProfile() async {
    debugPrint('${Get.currentRoute} - getUserProfile called');
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString('user');
      if (userJson != null) {
        final user = User.fromJson(jsonDecode(userJson));
        debugPrint('${Get.currentRoute} - getUserProfile successful: ${user.toJson()}');
        return user;
      }
      debugPrint('${Get.currentRoute} - getUserProfile: No user data found in SharedPreferences');
      return null;
    } catch (e) {
      debugPrint('${Get.currentRoute} - getUserProfile exception: $e');
      throw Exception('Failed to load user profile: $e');
    }
  }

  Future<String?> getCurrentUserId() async {
    debugPrint('${Get.currentRoute} - getCurrentUserId called');
    if (_currentUserId != null) {
      debugPrint('${Get.currentRoute} - getCurrentUserId returning cached ID: $_currentUserId');
      return _currentUserId;
    }
    final prefs = await SharedPreferences.getInstance();
    _currentUserId = prefs.getString(uuidKey);
    debugPrint('${Get.currentRoute} - UUID retrieved from SharedPreferences: $_currentUserId');
    return _currentUserId;
  }

  Future<void> signOut() async {
    debugPrint('${Get.currentRoute} - signOut called');
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(uuidKey);
    await prefs.remove('user');
    _currentUserId = null;
    _isLoggedIn.value = false;
    debugPrint('${Get.currentRoute} - signOut successful');
  }

  Future<bool> isLoggedIn() async {
    debugPrint('${Get.currentRoute} - isLoggedIn called');
    final prefs = await SharedPreferences.getInstance();
    final loggedIn = prefs.containsKey(uuidKey);
    debugPrint('${Get.currentRoute} - isLoggedIn returning: $loggedIn');
    return loggedIn;
  }

  Future<void> refreshToken() async {
    debugPrint('${Get.currentRoute} - refreshToken called');
    throw UnimplementedError('refreshToken not implemented');
  }
}
