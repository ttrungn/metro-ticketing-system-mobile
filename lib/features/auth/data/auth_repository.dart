import 'dart:convert';

import 'package:metro_ticketing_system_mobile/core/network/api_client.dart';

class AuthRepository {
  AuthRepository();

  Future<Map<String, dynamic>> loginUser(Map<String, dynamic> data) async {
    final response = await ApiClient.dio.post(
      '/auth/login',
      data: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return response.data as Map<String, dynamic>;
    }

    return response.data?.error?.message;
  }

  Future<Map<String, dynamic>> registerUser(Map<String, dynamic> data) async {
    final response = await ApiClient.dio.post(
      '/auth/register',
      data: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return response.data as Map<String, dynamic>;
    }

    return response.data?.error?.message;
  }
}
