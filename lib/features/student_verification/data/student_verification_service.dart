import 'package:injectable/injectable.dart';
import 'package:metro_ticketing_system_mobile/features/student_verification/data/models/student_verification_request.dart';
import 'package:metro_ticketing_system_mobile/features/student_verification/data/student_verification_repository.dart';

@lazySingleton
class StudentVerificationService {
  final StudentVerificationRepository _repo;

  StudentVerificationService(this._repo);

  Future<Map<String, dynamic>> submitVerificationRequest(
    StudentVerificationRequest request,
  ) async {
    try {
      return await _repo.submitVerificationRequest(request.toFormData());
    } catch (e) {
      throw Exception('Failed to submit verification request: $e');
    }
  }
}
