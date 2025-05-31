import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metro_ticketing_system_mobile/core/constants/app_color.dart';
import 'package:metro_ticketing_system_mobile/features/student_verification/logic/verification_cubit.dart';
import 'dart:io';

class SubmitButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final String studentCode;
  final String school;
  final String fullName;
  final String dob;
  final File? studentCardImage;

  const SubmitButton({
    super.key,
    required this.formKey,
    required this.studentCode,
    required this.school,
    required this.fullName,
    required this.dob,
    required this.studentCardImage,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VerificationCubit, VerificationState>(
      listener: (context, state) {
        if (state is VerificationFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }

        if (state is VerificationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Verification submitted successfully!")));
        }
      },
      builder: (context, state) {
        if (state is VerificationLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ConstantAppColor.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              if (formKey.currentState!.validate() && studentCardImage != null) {
                context.read<VerificationCubit>().submitVerification(
                  studentCode: studentCode,
                  school: school,
                  fullName: fullName,
                  dob: dob,
                  studentCardImage: studentCardImage!,
                );
              } else if (studentCardImage == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Upload student card image')),
                );
              }
            },
            child: const Text(
              "Submit Form",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }
}
