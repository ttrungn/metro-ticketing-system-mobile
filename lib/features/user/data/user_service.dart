import 'package:injectable/injectable.dart';
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
}