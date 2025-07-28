import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:metro_ticketing_system_mobile/core/configs/api_client.dart';

@lazySingleton
class StudentVerificationRepository {
  StudentVerificationRepository();

  Future<Map<String, dynamic>> submitVerificationRequest(FormData data) async {
    try {
      final response = await ApiClient.dio.post(
        '/user/StudentRequest/',
        data: data,
        options: Options(contentType: 'multipart/form-data'),
      );

      return response.data;
    } catch (e) {
      throw Exception('Failed to submit verification request: $e');
    }
  }
}
