import 'package:dio/dio.dart';
import 'package:metro_ticketing_system_mobile/core/configs/env.dart';
import 'package:metro_ticketing_system_mobile/core/storage/secure_storage.dart';

class ApiClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: Env.apiUrl,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  static void init() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await SecureStorage().readSecureData(
            key: 'accessToken',
          );
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException err, handler) {
          return handler.next(err);
        },
      ),
    );
  }
}
