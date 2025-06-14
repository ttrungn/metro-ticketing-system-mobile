import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:metro_ticketing_system_mobile/features/student_verification/data/models/student_verification_request.dart';
import 'package:metro_ticketing_system_mobile/features/student_verification/data/student_verification_repository.dart';
@lazySingleton
class StudentVerificationService {
  final StudentVerificationRepository _repo;

  StudentVerificationService(this._repo);

  Future<Response> submitVerificationRequest(StudentVerificationRequest request) async {
    try {
     final formData = request.toFormData();
      return await _repo.submitVerificationRequest(formData);
    } catch (e) {
      throw Exception('Failed to submit verification request: $e');
    }
  }
}