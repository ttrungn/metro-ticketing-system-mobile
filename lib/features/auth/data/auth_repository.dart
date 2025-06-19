import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:metro_ticketing_system_mobile/core/configs/api_client.dart';

@lazySingleton
class AuthRepository {
  AuthRepository();

  Future<Map<String, dynamic>> loginUser(Map<String, dynamic> data) async {
    final response = await ApiClient.dio.post(
      '/user/auth/login',
      data: jsonEncode(data),
    );

    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> registerUser(Map<String, dynamic> data) async {
    final response = await ApiClient.dio.post(
      '/user/auth/register/customer',
      data: jsonEncode(data),
    );

    return response.data as Map<String, dynamic>;
  }
}
