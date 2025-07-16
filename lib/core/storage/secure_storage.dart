import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SecureStorage {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<void> writeSecureData({
    required String key,
    required String value,
  }) async {
    await secureStorage.write(key: key, value: value);
  }

  Future<String?> readSecureData({required String key}) async {
    return await secureStorage.read(key: key);
  }

  Future<void> deleteSecureData({required String key}) async {
    await secureStorage.delete(key: key);
  }
}
