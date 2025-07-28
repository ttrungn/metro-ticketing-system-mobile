import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metro_ticketing_system_mobile/core/constants/app_color.dart';
import 'package:metro_ticketing_system_mobile/core/di/service_locator.dart';
import 'package:metro_ticketing_system_mobile/features/student_verification/presentation/widgets/verification_form.dart';
import 'package:metro_ticketing_system_mobile/features/student_verification/logic/verification_cubit.dart';

class VerificationFormScreen extends StatelessWidget {
  const VerificationFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<VerificationCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Xác thực sinh viên'),
          backgroundColor: ConstantAppColor.primary,
        ),
        body: const Padding(
          padding: EdgeInsets.all(16),
          child: VerificationForm(),
        ),
      ),
    );
  }
}
