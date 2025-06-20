import 'package:injectable/injectable.dart';
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

}