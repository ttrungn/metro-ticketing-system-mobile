import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:metro_ticketing_system_mobile/core/storage/secure_storage.dart';
import 'package:metro_ticketing_system_mobile/features/auth/data/auth_service.dart';
import 'package:metro_ticketing_system_mobile/features/auth/data/models/login_request.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginFinished extends LoginState {
  final Map<String, dynamic> data;

  LoginFinished(this.data);
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure(this.error);
}

class LoginCubit extends Cubit<LoginState> {
  final AuthService _authService;
  LoginCubit(this._authService) : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    try {
      final response = await _authService.loginUser(
        LoginRequest(email: email, password: password),
      );

      if (response['accessToken'] != null) {
        await SecureStorage().writeSecureData(
          key: 'accessToken',
          value: response['accessToken'],
        );
      }
      emit(LoginFinished(response));
    } catch (_) {
      emit(LoginFailure("Cannot login right now, please try again later!"));
    }
  }
}
