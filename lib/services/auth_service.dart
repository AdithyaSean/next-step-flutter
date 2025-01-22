import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService extends GetxService {
  Future<AuthService> init() async {
    return this;
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
  );
  final _storage = const FlutterSecureStorage();
  final String _baseUrl = 'http://localhost:8080/auth';
  final Rx<Map<String, dynamic>> currentUser = Rx<Map<String, dynamic>>({});

  Future<Map<String, dynamic>> signInWithGoogle() async {
    try {
      print('Starting Google sign-in flow...');
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        print('Google sign-in was cancelled by user');
        throw Exception('Google sign in cancelled');
      }

      print('Google user obtained: ${googleUser.email}');
      final GoogleSignInAuthentication googleAuth = 
          await googleUser.authentication;
      print('Google auth tokens received - ID Token: ${googleAuth.idToken != null ? "received" : "missing"}, Access Token: ${googleAuth.accessToken != null ? "received" : "missing"}');

      print('Calling backend auth endpoint: $_baseUrl/google');
      final response = await http.post(
        Uri.parse('$_baseUrl/google'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'idToken': googleAuth.idToken,
          'accessToken': googleAuth.accessToken,
        }),
      );

      print('Backend response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        print('Successfully authenticated with backend. User data: ${responseData['user']}');
        await _storeTokens(responseData);
        print('Tokens stored successfully');
        currentUser.value = responseData['user'];
        return responseData;
      } else {
        print('Backend authentication failed with status ${response.statusCode}');
        throw Exception('Failed to authenticate with backend');
      }
    } catch (e) {
      print('Authentication error: ${e.toString()}');
      throw Exception('Authentication failed: ${e.toString()}');
    }
  }

  Future<void> _storeTokens(Map<String, dynamic> tokens) async {
    print('Storing access token: ${tokens['accessToken']?.substring(0, 10)}...');
    print('Storing refresh token: ${tokens['refreshToken']?.substring(0, 10)}...');
    await _storage.write(key: 'access_token', value: tokens['accessToken']);
    await _storage.write(key: 'refresh_token', value: tokens['refreshToken']);
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: 'access_token');
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _storage.deleteAll();
    currentUser.value = {};
  }

  Future<void> refreshToken() async {
    final refreshToken = await _storage.read(key: 'refresh_token');
    if (refreshToken == null) {
      throw Exception('No refresh token available');
    }

    final response = await http.post(
      Uri.parse('$_baseUrl/refresh'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'refreshToken': refreshToken}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      await _storeTokens(responseData);
    } else {
      throw Exception('Failed to refresh token');
    }
  }

  Future<Map<String, dynamic>> getUserProfile() async {
    final accessToken = await getAccessToken();
    if (accessToken == null) {
      throw Exception('Not authenticated');
    }

    final response = await http.get(
      Uri.parse('$_baseUrl/me'),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      await refreshToken();
      return getUserProfile();
    } else {
      throw Exception('Failed to fetch user profile');
    }
  }

  Future<bool> isAuthenticated() async {
    final accessToken = await getAccessToken();
    return accessToken != null;
  }
}
