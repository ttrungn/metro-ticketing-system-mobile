import 'package:injectable/injectable.dart';
import 'package:metro_ticketing_system_mobile/core/configs/api_client.dart';

@lazySingleton
class UserRepository {
  UserRepository();

  Future<Map<String, dynamic>> getUserInfo() async {
    final response = await ApiClient.dio.get('/user/Profiles');
    return response.data["data"] as Map<String, dynamic>;
  }
}