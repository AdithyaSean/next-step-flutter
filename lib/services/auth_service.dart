import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:next_step/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  static const String baseUrl = 'http://localhost:8080';
  static const String uuidKey = 'UUID';
  final http.Client client;
  final bool isTest;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  AuthService(this.client, {this.isTest = false});

  Future<void> initAsync() async {
    debugPrint('Initializing AuthService');
    final prefs = await _prefs;
    final uuid = prefs.getString(uuidKey);
    if (uuid != null) {
      debugPrint('Found existing UUID: $uuid');
      try {
        await refreshToken();
      } catch (e) {
        debugPrint('Token refresh failed: $e');
        await signOut();
      }
    }
  }

  Future<bool> isLoggedIn() async {
    final uuid = await getCurrentUserId();
    return uuid != null;
  }

  Future<String?> getCurrentUserId() async {
    final prefs = await _prefs;
    return prefs.getString(uuidKey);
  }

  String _handleConnectionError(dynamic error) {
    final errorStr = error.toString().toLowerCase();
    if (errorStr.contains('connection refused') || 
        errorStr.contains('failed to fetch') ||
        errorStr.contains('socket') ||
        errorStr.contains('cors')) {
      return 'Unable to connect to server. Please ensure the server is running and accessible.';
    }
    return 'An unexpected error occurred. Please try again.';
  }

  Future<User?> getUserProfile([String? uuid]) async {
    debugPrint('getUserProfile called');
    try {
      final userId = uuid ?? await getCurrentUserId();
      if (userId == null) {
        debugPrint('getUserProfile: No user data found in SharedPreferences');
        return null;
      }

      final response = await client.get(
        Uri.parse('$baseUrl/students/profile'),
        headers: {
          'Content-Type': 'application/json',
          'UUID': userId,
        },
      );

      if (response.statusCode == 200) {
        if (response.body.isEmpty) {
          debugPrint('getUserProfile: Empty response body');
          return null;
        }
        try {
          final profileData = json.decode(response.body);
          if (profileData == null) {
            debugPrint('getUserProfile: Null profile data after JSON decode');
            return null;
          }
          return User.fromProfile(profileData);
        } catch (e) {
          debugPrint('getUserProfile JSON decode error: $e');
          return null;
        }
      }
      return null;
    } catch (e) {
      debugPrint('getUserProfile error: $e');
      return null;
    }
  }

  Future<bool> _isProfileComplete(User user) {
    switch (user.educationLevel) {
      case 0: // OL
        return Future.value(user.olResults.isNotEmpty);
      case 1: // AL
        return Future.value(user.olResults.isNotEmpty && 
                          user.alStream != null && 
                          user.alResults.isNotEmpty);
      case 2: // University
        return Future.value(user.olResults.isNotEmpty && 
                          user.alStream != null && 
                          user.alResults.isNotEmpty && 
                          user.gpa != 0.0);
      default:
        return Future.value(false);
    }
  }

  Future<bool> refreshToken() async {
    debugPrint('Refreshing token');
    try {
      final uuid = await getCurrentUserId();
      if (uuid == null) return false;

      final user = await getUserProfile(uuid);
      return user != null;
    } catch (e) {
      debugPrint('Token refresh failed: $e');
      return false;
    }
  }

  Future<User?> signIn(String username, String password) async {
    debugPrint('signIn called with username: $username');
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'password': password,
        }),
      );

      debugPrint('signIn response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final userData = json.decode(response.body);
        final user = User.fromJson(userData);

        // First save UUID
        final prefs = await _prefs;
        await prefs.setString(uuidKey, user.id);
        debugPrint('UUID saved: ${user.id}');

        final savedUuid = await prefs.getString(uuidKey);
        if (savedUuid == null) {
          throw Exception('Failed to save UUID');
        }
        
        // Then load student profile
        debugPrint('Fetching student profile from: $baseUrl/students/profile');
        final profileResponse = await client.get(
          Uri.parse('$baseUrl/students/profile'),
          headers: {
            'Content-Type': 'application/json',
            'UUID': savedUuid,
          },
        );

        debugPrint('Student profile response status: ${profileResponse.statusCode}');
        debugPrint('Student profile response body: ${profileResponse.body}');

        if (profileResponse.statusCode == 200) {
          if (profileResponse.body.isEmpty) {
            debugPrint('Empty profile response body, redirecting to EditProfile');
            if (!isTest) {
              Get.offAllNamed('/profile/edit');
            }
            return user;
          }

          try {
            final profileData = json.decode(profileResponse.body);
            if (profileData == null) {
              debugPrint('Null profile data after JSON decode, redirecting to EditProfile');
              if (!isTest) {
                Get.offAllNamed('/profile/edit');
              }
              return user;
            }
            user.updateFromProfile(profileData);
            debugPrint('Complete user profile: ${user.toJson()}');

            final isComplete = await _isProfileComplete(user);
            debugPrint('signIn profile completion check: $isComplete');
            if (isComplete) {
              debugPrint('signIn navigating to HomeScreen');
              if (!isTest) {
                Get.offAllNamed('/home');
              }
            } else {
              debugPrint('signIn navigating to EditProfile');
              if (!isTest) {
                Get.offAllNamed('/profile/edit');
              }
            }
            return user;
          } catch (e) {
            debugPrint('Profile JSON decode error: $e, returning user without profile');
            return user;
          }
        }

        debugPrint('Failed to load student profile status: ${profileResponse.statusCode}');
        return user; // Return user even if profile fetch fails
      }
      final errorMessage = response.statusCode == 500 ? 
        'Invalid username or password' : 'Server error, please try again';
      throw Exception(errorMessage);
    } catch (e) {
      debugPrint('signIn exception: $e');
      throw Exception(_handleConnectionError(e));
    }
  }

  Future<User> signUp({
    required String username,
    required String password,
    required String name,
    required String email,
    required String telephone,
    required String school,
    required String district,
  }) async {
    debugPrint('signUp called with username: $username');
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/students'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'name': name,
          'email': email,
          'password': password,
          'telephone': telephone,
          'role': 'STUDENT',
          'school': school,
          'district': district,
        }),
      );

      if (response.statusCode == 201) {
        final userData = json.decode(response.body);
        final user = User.fromJson(userData);

        final prefs = await _prefs;
        await prefs.setString(uuidKey, user.id);
        debugPrint('UUID saved after sign up: ${user.id}');

        return user;
      }

      if (response.statusCode == 500 && response.body.toLowerCase().contains("duplicate")) {
        throw Exception(response.body); // Preserve original error for test
      }
      throw Exception('Failed to create account');
    } catch (e) {
      debugPrint('signUp exception: $e');
      if (e is Exception) {
        rethrow; // Re-throw if it's already an Exception
      }
      throw Exception(_handleConnectionError(e));
    }
  }

  Future<void> signOut() async {
    debugPrint('/HomeScreen - signOut called');
    try {
      final prefs = await _prefs;
      await prefs.clear();
      debugPrint('/HomeScreen - signOut successful');
      if (!isTest) {
        Get.offAllNamed('/login');
      }
    } catch (e) {
      debugPrint('/HomeScreen - signOut failed: $e');
      rethrow;
    }
  }

  Future<User> updateProfile(
    String uuid, {
    required int educationLevel,
    required Map<String, double> olResults,
    int? alStream,
    Map<String, double>? alResults,
    double? gpa,
  }) async {
    debugPrint('updateProfile called with UUID: $uuid');
    try {
      final Map<String, dynamic> profileData = {
        'educationLevel': educationLevel,
        'olResults': olResults,
      };

      if (alStream != null) {
        profileData['alStream'] = alStream;
      }

      if (alResults != null) {
        profileData['alResults'] = alResults;
      }

      if (gpa != null) {
        profileData['gpa'] = gpa;
      }

      final response = await client.put(
        Uri.parse('$baseUrl/students/profile'),
        headers: {
          'Content-Type': 'application/json',
          'UUID': uuid,
        },
        body: json.encode(profileData),
      );

      debugPrint('updateProfile response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final updatedProfileData = json.decode(response.body);
        final user = User.fromProfile(updatedProfileData);
        debugPrint('Profile updated successfully: ${user.toJson()}');
        return user;
      }

      debugPrint('Failed to update profile: ${response.body}');
      throw Exception('Failed to update profile. Please try again.');
    } catch (e) {
      debugPrint('updateProfile exception: $e');
      throw Exception(_handleConnectionError(e));
    }
  }
}
