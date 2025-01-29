import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kuber_steels/pages/dialog_utils.dart';

class StorageService {

  static const _storage = FlutterSecureStorage();

  static Future<void> storeToken(String token) async {
    try {
      print("token $token");
      await _storage.write(key: 'auth_token', value: token);
    } catch (e) {
      DialogUtils.showErrorDialog('Error storing token: $e');
    }
  }

  static Future<String?> getToken() async {
    try {
      return await _storage.read(key: 'auth_token');
    } catch (e) {
      DialogUtils.showErrorDialog('Error retrieving token: $e');
      return null;
    }
  }

  static Future<void> removeToken() async {
    try {
      await _storage.delete(key: 'auth_token');
    } catch (e) {
      DialogUtils.showErrorDialog("Error deleting data: $e");
    }
  }
}