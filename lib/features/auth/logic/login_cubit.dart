import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:metro_ticketing_system_mobile/core/storage/secure_storage.dart';
import 'package:metro_ticketing_system_mobile/features/auth/data/auth_service.dart';
import 'package:metro_ticketing_system_mobile/features/auth/data/models/login_request.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final Map<String, dynamic> data;

  LoginSuccess(this.data);
}

class LoginFailure extends LoginState {
  final String message;

  LoginFailure(this.message);
}

@injectable
class LoginCubit extends Cubit<LoginState> {
  final AuthService _authService;
  final SecureStorage _secureStorage;

  LoginCubit(this._authService, this._secureStorage) : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());

    try {
      final response = await  _authService.loginUser(
        LoginRequest(email: email.trim(), password: password),
      );

      await _secureStorage.writeSecureData(
        key: 'accessToken',
        value: response['token'],
      );

      emit(LoginSuccess(response));
    } on DioException catch (e) {
      emit(
        LoginFailure(
          e.response?.data['message'] ??
              'Đã xảy ra lỗi không xác định. Vui lòng thử lại sau.',
        ),
      );
    } catch (e) {
      emit(LoginFailure('Đã xảy ra lỗi không xác định. Vui lòng thử lại sau.'));
    }
  }

  void resetState() {
    emit(LoginInitial());
  }
}