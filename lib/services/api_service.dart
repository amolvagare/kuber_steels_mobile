import 'dart:convert';

import 'package:kuber_steels/services/storage.dart';
import 'package:http/http.dart' as http;
import 'package:kuber_steels/models/user.dart';
import 'package:kuber_steels/models/product.dart';
import 'package:kuber_steels/models/customer.dart';

class ApiService {
  // get logged in user info
  Future<User> getUserInfo() async {
    final token = await StorageService.getToken();
    if (token == null) {
      throw Exception('No token available');
    }

    const String apiUrl =
        'http://localhost:8000/api/user'; // Adjust URL as needed
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return User.fromJson(responseData);
      } else {
        throw Exception('Failed to fetch user data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  // get products info
  Future<List<Product>> getProducts() async {
    final token = await StorageService.getToken();
    if (token == null) {
      throw Exception('No token available');
    }

    const String apiUrl = 'http://127.0.0.1:8000/api/v1/products';
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        return responseData.map((json) => Product.fromJson(json)).toList();
      } else if (response.statusCode == 401) {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['detail'] ?? 'Authentication failed');
      } else {
        throw Exception('Failed to fetch products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  Future<List<Customer>> getCustomers({String? searchQuery}) async {
    final token = await StorageService.getToken();
    if (token == null) {
      throw Exception('No token available');
    }

    final String apiUrl = searchQuery != null
        ? 'http://127.0.0.1:8000/api/v1/customers?search=$searchQuery'
        : 'http://127.0.0.1:8000/api/v1/customers';

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final List<dynamic> results = responseData['results'];
        return results.map((json) => Customer.fromJson(json)).toList();
      } else if (response.statusCode == 401) {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['detail'] ?? 'Authentication failed');
      } else {
        throw Exception('Failed to fetch customers: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }
}
