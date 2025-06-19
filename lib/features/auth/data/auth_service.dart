import 'package:injectable/injectable.dart';
import 'package:metro_ticketing_system_mobile/features/auth/data/auth_repository.dart';
import 'package:metro_ticketing_system_mobile/features/auth/data/models/login_request.dart';
import 'package:metro_ticketing_system_mobile/features/auth/data/models/register_request.dart';

@lazySingleton
class AuthService {
  final AuthRepository _authRepository;

  AuthService(this._authRepository);

  Future<Map<String, dynamic>> loginUser(LoginRequest loginRequest) async {
    return await _authRepository.loginUser(loginRequest.toJson());
  }

  Future<Map<String, dynamic>> registerUser(
    RegisterRequest registerRequest,
  ) async {
    return await _authRepository.registerUser(registerRequest.toJson());
  }
}
