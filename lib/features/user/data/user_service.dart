import 'package:injectable/injectable.dart';
import 'package:metro_ticketing_system_mobile/features/feedback/data/models/feedback_model.dart';
import 'package:metro_ticketing_system_mobile/features/feedback/data/models/feedback_request.dart';
import 'package:metro_ticketing_system_mobile/features/feedback/data/models/feedback_type.dart';
import 'package:metro_ticketing_system_mobile/features/feedback/data/models/station_model.dart';
import 'package:metro_ticketing_system_mobile/features/user/data/models/profile_info.dart';
import 'package:metro_ticketing_system_mobile/features/user/data/user_repository.dart';

@lazySingleton
class UserService {
  final UserRepository _userRepository;
  UserService(this._userRepository);

  Future<ProfileInfo> getUserInfo() async {
    final response = await _userRepository.getUserInfo();
    return ProfileInfo.fromJson(response);
  }

  Future<List<FeedbackType>> fetchFeedbackTypes() async {
    final dataList = await _userRepository.fetchFeedbackTypes();
    return dataList.map((e) => FeedbackType.fromJson(e)).toList();
  }

  Future<List<StationModel>> fetchStations() async {
    final dataList = await _userRepository.fetchStations();
    return dataList.map((e) => StationModel.fromJson(e)).toList();
  }

  Future<List<FeedbackModel>> fetchFeedbacks() async {
    final dataList = await _userRepository.fetchFeedbacks();
    return dataList.map((e) => FeedbackModel.fromJson(e)).toList();
  }

  Future<void> submitFeedback(FeedbackRequest feedback) async {
    await _userRepository.submitFeedback(feedback.toJson());
  }
}
