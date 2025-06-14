import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:metro_ticketing_system_mobile/core/configs/api_client.dart';
import 'package:metro_ticketing_system_mobile/core/storage/secure_storage.dart';

@lazySingleton
class StudentVerificationRepository {
  final SecureStorage _secureStorage;

  StudentVerificationRepository(this._secureStorage);

  Future<Response> submitVerificationRequest(FormData data) async {
    try {
      final token = await _secureStorage.readSecureData(key: 'accessToken');
      final response = await ApiClient.dio.post(
        '/user/StudentRequest/',
        data: data,
          options: Options(contentType: 'multipart/form-data',
          headers: {
            'Authorization': 'Bearer $token',
          }
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to submit verification request: $e');
    }
  }
}

