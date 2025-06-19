import 'dart:io';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';


class StudentVerificationRequest {
  final String studentCode;
  final String studentEmail;
  final String schoolName;
  final String firstName;
  final String lastName;
  // final String fullName;
  final DateTime dateOfBirth;
  final File? studentCardImage;

  StudentVerificationRequest({
    required this.studentCode,
    required this.studentEmail,
    required this.schoolName,
    required this.firstName,
    required this.lastName,
    // required this.fullName, /
    required this.dateOfBirth,
    this.studentCardImage,
  });

FormData toFormData() {
    final formData = FormData.fromMap({
      'studentCode': studentCode,
      'studentEmail': studentEmail,
      'schoolName': schoolName,
      'firstName': firstName,
      'lastName': lastName,
      // 'fullName': fullName,
      'dateOfBirth': DateFormat('yyyy-MM-dd').format(dateOfBirth),
    });

    if (studentCardImage != null) {
      formData.files.add(
        MapEntry(
          'studentCardImage',
          MultipartFile.fromFileSync(studentCardImage!.path, filename: 'student_card.jpg'),
        ),
      );
    }

    return formData;
  }
}