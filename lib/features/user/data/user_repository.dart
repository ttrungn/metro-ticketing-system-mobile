import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:metro_ticketing_system_mobile/core/configs/api_client.dart';

@lazySingleton
class UserRepository {
  UserRepository();

  Future<Map<String, dynamic>> getUserInfo() async {
    final response = await ApiClient.dio.get('/user/Profiles');
    return response.data["data"] as Map<String, dynamic>;
  }

  Future<List<Map<String, dynamic>>> fetchFeedbackTypes() async {
    final response = await ApiClient.dio.get('/user/FeedbackTypes');
    return List<Map<String, dynamic>>.from(response.data["data"]);
  }

  Future<List<Map<String, dynamic>>> fetchStations() async {
    final response = await ApiClient.dio.get(
      '/catalog/Stations?page=0&pageSize=100&status=false',
    );
    final stations = response.data["data"]["stations"] as List;
    return stations.map((station) {
      return {"id": station["id"] as String, "name": station["name"] as String};
    }).toList();
  }

  Future<List<Map<String, dynamic>>> fetchFeedbacks() async {
    final response = await ApiClient.dio.get('/user/Feedbacks');
    print(response.data["data"]);
    return List<Map<String, dynamic>>.from(response.data["data"]);
  }

  Future<void> submitFeedback(Map<String, dynamic> feedback) async {
    await ApiClient.dio.post('/user/Feedbacks', data: jsonEncode(feedback));
  }
}
