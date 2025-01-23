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
    clientId: '114713348296-mg494lco1s815jnqolcrapv4l3qkoias.apps.googleusercontent.com',
    hostedDomain: '',
    signInOption: SignInOption.standard,
  );
  final _storage = const FlutterSecureStorage();
  final String _baseUrl = 'http://localhost:8080';
  final Rx<Map<String, dynamic>> currentUser = Rx<Map<String, dynamic>>({});

  Future<Map<String, dynamic>> signInWithGoogle() async {
    try {
      print('Starting Google sign-in flow...');
      
      // Initialize the Google Sign-In client
      await _googleSignIn.signOut(); // Clear any existing session
      
      // Start the interactive sign-in flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        print('Google sign-in was cancelled by user');
        throw Exception('Google sign in cancelled');
      }

      // Get authentication tokens
      final GoogleSignInAuthentication googleAuth = 
          await googleUser.authentication;
          
      if (googleAuth.idToken == null) {
        print('No ID token received from Google');
        throw Exception('No ID token received');
      }

      print('Google user obtained: ${googleUser.email}');
      print('Google auth tokens received - ID Token: ${googleAuth.idToken != null ? "received" : "missing"}, Access Token: ${googleAuth.accessToken != null ? "received" : "missing"}');

      // Call backend auth endpoint with the new GIS flow
      print('Calling backend auth endpoint: $_baseUrl/google');
      final response = await http.post(
        Uri.parse('$_baseUrl/google'),
        headers: {
          'Content-Type': 'application/json',
          'X-Google-Client-ID': '114713348296-mg494lco1s815jnqolcrapv4l3qkoias.apps.googleusercontent.com'
        },
        body: jsonEncode({
          'idToken': googleAuth.idToken,
          'accessToken': googleAuth.accessToken,
          'clientId': '114713348296-mg494lco1s815jnqolcrapv4l3qkoias.apps.googleusercontent.com',
          'redirectUri': 'http://localhost:3000'
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
    print('[${DateTime.now()}] Starting token refresh...');
    final refreshToken = await _storage.read(key: 'refresh_token');
    if (refreshToken == null) {
      print('[${DateTime.now()}] No refresh token available');
      throw Exception('No refresh token available');
    }

    print('[${DateTime.now()}] Attempting token refresh with refresh token: ${refreshToken.substring(0, 10)}...');
    final response = await http.post(
      Uri.parse('$_baseUrl/refresh'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'refreshToken': refreshToken}),
    );

    print('[${DateTime.now()}] Token refresh response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      print('[${DateTime.now()}] Token refresh successful. New access token: ${responseData['accessToken']?.substring(0, 10)}...');
      await _storeTokens(responseData);
    } else {
      print('[${DateTime.now()}] Token refresh failed with status ${response.statusCode}. Response body: ${response.body}');
      throw Exception('Failed to refresh token');
    }
  }

  Future<Map<String, dynamic>> getUserProfile() async {
    print('[${DateTime.now()}] Fetching user profile...');
    final accessToken = await getAccessToken();
    if (accessToken == null) {
      print('[${DateTime.now()}] No access token available');
      throw Exception('Not authenticated');
    }

    print('[${DateTime.now()}] Making profile request with access token: ${accessToken.substring(0, 10)}...');
    final response = await http.get(
      Uri.parse('$_baseUrl/me'),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    print('[${DateTime.now()}] Profile response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      final profileData = jsonDecode(response.body);
      print('[${DateTime.now()}] Successfully fetched profile data: ${profileData['email']}');
      return profileData;
    } else if (response.statusCode == 401) {
      print('[${DateTime.now()}] Access token expired, attempting refresh...');
      await refreshToken();
      return getUserProfile();
    } else {
      print('[${DateTime.now()}] Failed to fetch profile. Status: ${response.statusCode}, Body: ${response.body}');
      throw Exception('Failed to fetch user profile');
    }
  }

  Future<bool> isAuthenticated() async {
    final accessToken = await getAccessToken();
    return accessToken != null;
  }

  Future<Map<String, dynamic>> signUpWithEmail({required String email, required String password}) async {
    try {
      print('Starting email sign-up flow...');
      final response = await http.post(
        Uri.parse('$_baseUrl/users'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        await _storeTokens(responseData);
        currentUser.value = responseData['user'];
        return responseData;
      } else {
        throw Exception('Failed to sign up: ${response.body}');
      }
    } catch (e) {
      throw Exception('Sign up failed: ${e.toString()}');
    }
  }
}
