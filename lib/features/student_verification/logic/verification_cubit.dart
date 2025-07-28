import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:metro_ticketing_system_mobile/features/student_verification/data/models/student_verification_request.dart';
import 'package:metro_ticketing_system_mobile/features/student_verification/data/student_verification_service.dart';

@immutable
abstract class VerificationState {}

class VerificationInitial extends VerificationState {}

class VerificationLoading extends VerificationState {}

class VerificationSuccess extends VerificationState {
  final Map<String, dynamic> data;

  VerificationSuccess(this.data);
}

class VerificationFailure extends VerificationState {
  final String message;

  VerificationFailure(this.message);
}

@injectable
class VerificationCubit extends Cubit<VerificationState> {
  final StudentVerificationService _studentVerificationService;
  VerificationCubit(this._studentVerificationService)
    : super(VerificationInitial());

  Future<void> submitVerification({
    required String studentCode,
    required String studentEmail,
    required String schoolName,
    required String firstName,
    required String lastName,
    // required String fullName,
    required DateTime dateOfBirth,
    required File studentCardImage,
  }) async {
    emit(VerificationLoading());

    try {
      final request = StudentVerificationRequest(
        studentCode: studentCode.trim(),
        studentEmail: studentEmail.trim(),
        schoolName: schoolName.trim(),
        firstName: firstName,
        lastName: lastName,
        // fullName: fullName,
        dateOfBirth: dateOfBirth,
        studentCardImage: studentCardImage,
      );
      final responseData = await _studentVerificationService
          .submitVerificationRequest(request);

      emit(VerificationSuccess(responseData));
    } catch (e) {
      emit(VerificationFailure('Error: ${e.toString()}'));
    }
  }
}
