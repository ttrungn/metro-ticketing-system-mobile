import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';


class VerificationCubit extends Cubit<VerificationState> {
  VerificationCubit() : super(VerificationInitial());

  Future<void> submitVerification({
    required String studentCode,
    required String school,
    required String fullName,
    required String dob,
    required File studentCardImage,
  }) async {
    try {
      emit(VerificationLoading());

      await Future.delayed(const Duration(seconds: 2)); // giả lập API
      // Gửi dữ liệu lên server tại đây

      emit(VerificationSuccess());
    } catch (e) {
      emit(VerificationFailure(error: e.toString()));
    }
  }
}

// verification_state.dart
abstract class VerificationState {}

class VerificationInitial extends VerificationState {}
class VerificationLoading extends VerificationState {}
class VerificationSuccess extends VerificationState {}
class VerificationFailure extends VerificationState {
  final String error;
  VerificationFailure({required this.error});
}
