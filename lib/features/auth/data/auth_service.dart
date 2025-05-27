import 'package:metro_ticketing_system_mobile/features/auth/data/auth_repository.dart';
import 'package:metro_ticketing_system_mobile/features/auth/data/models/login_request.dart';
import 'package:metro_ticketing_system_mobile/features/auth/data/models/register_request.dart';

class AuthService {
  final AuthRepository authRepository;

  AuthService(this.authRepository);
  Future<Map<String, dynamic>> loginUser(LoginRequest loginRequest) async {
    return await authRepository.loginUser(loginRequest.toJson());
  }
  Future<Map<String, dynamic>> registerUser(RegisterRequest registerRequest) async {
    return await authRepository.registerUser(registerRequest.toJson());
  }
}