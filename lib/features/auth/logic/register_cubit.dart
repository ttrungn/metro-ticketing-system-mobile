import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:metro_ticketing_system_mobile/features/auth/data/auth_service.dart';
import 'package:metro_ticketing_system_mobile/features/auth/data/models/register_request.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final Map<String, dynamic> data;

  RegisterSuccess(this.data);
}

class RegisterFailure extends RegisterState {
  final String message;

  RegisterFailure(this.message);
}

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  final AuthService _authService;

  RegisterCubit(this._authService) : super(RegisterInitial());

  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    emit(RegisterLoading());

    try {
      final response = await _authService.registerUser(
        RegisterRequest(
          firstName: firstName.trim(),
          lastName: lastName.trim(),
          email: email.trim().toLowerCase(),
          password: password,
        ),
      );

      emit(RegisterSuccess(response));
    } on DioException catch (e) {
      emit(RegisterFailure(e.error.toString()));
    } catch (e) {
      emit(
        RegisterFailure('Đã xảy ra lỗi không xác định. Vui lòng thử lại sau.'),
      );
    }
  }

  void resetState() {
    emit(RegisterInitial());
  }
}
