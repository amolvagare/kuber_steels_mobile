import 'dart:convert';

import 'package:kuber_steels/pages/dialog_utils.dart';
import 'package:kuber_steels/services/storage.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // Example API call with token
  Future<void> fetchData() async {
    final token = await StorageService.getToken();
    if (token == null) {
      // Handle case where token is not available
      return;
    }

    const String apiUrl =
        'http://localhost:8443/api/auth'; // Replace with your data API endpoint
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        // Handle successful data retrieval
        final responseData = jsonDecode(response.body);
        print('Data: $responseData');
      } else {
        // Handle API error
        DialogUtils.showErrorDialog(
            'Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network or other errors
      DialogUtils.showErrorDialog('An error occurred: $e');
    }
  }
}
