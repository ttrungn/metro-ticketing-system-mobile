import 'package:injectable/injectable.dart';
import 'package:metro_ticketing_system_mobile/core/configs/api_client.dart';
import 'models/response/bus_model.dart';

@lazySingleton
class BusRepository {
  BusRepository();

  Future<List<BusModel>> getBuses({Map<String, dynamic>? queryParams}) async {
    try {
      final response = await ApiClient.dio.get(
        '/catalog/Buses',
        queryParameters: queryParams,
      );
      final data = response.data['data'] as Map<String, dynamic>;
      final list = data['buses'] as List<dynamic>;
      return list
          .map((e) => BusModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to load buses: $e');
    }
  }
}
