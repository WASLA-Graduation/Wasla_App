import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SecureStorageHelper {
  static final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  // Write (Save) Data Securely
  static Future<void> set({required String key, required String value}) async {
    await _secureStorage.write(key: key, value: value);
  }

  // Read Data Securely
  static Future<String?> get({required String key}) async {
    return await _secureStorage.read(key: key);
  }

  // Delete Specific Key
  static Future<void> remove({required String key}) async {
    await _secureStorage.delete(key: key);
  }

  // Clear All Secure Data
  static Future<void> clear() async {
    await _secureStorage.deleteAll();
  }

  // Check if Key Exists
  static Future<bool> containsKey({required String key}) async {
    return await _secureStorage.containsKey(key: key);
  }
}
