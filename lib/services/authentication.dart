import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:kuber_steels/main.dart';
import 'package:kuber_steels/pages/dialog_utils.dart';
import 'package:kuber_steels/services/storage.dart';
import 'package:http/http.dart' as http;

class AuthenticationService {
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    const String apiUrl = 'http://127.0.0.1:8000/api/auth'; // Replace with your actual API endpoint

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        // Successful login
        final responseData = jsonDecode(response.body);
        final token = responseData[
            'accessToken']; // Adjust based on your API response structure

        if (token != null) {
          // Store the token securely
          await StorageService.storeToken(token);
          // Navigate to the next screen
          Navigator.pushReplacementNamed(navigatorKey.currentContext!,
              '/home'); // Replace '/home' with your home route
        } else {
          DialogUtils.showErrorDialog('Token not found in response');
        }
      } else {
        // Handle login failure
        DialogUtils.showErrorDialog('Login failed: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network or other errors
      DialogUtils.showErrorDialog('An error occurred: $e');
    }
  }

  Future<void> logOut() async {
    StorageService.removeToken();
  }
}
