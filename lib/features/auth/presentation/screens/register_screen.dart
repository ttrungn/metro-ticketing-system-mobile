import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metro_ticketing_system_mobile/core/constants/app_color.dart';
import 'package:metro_ticketing_system_mobile/core/di/service_locator.dart';
import 'package:metro_ticketing_system_mobile/features/auth/data/auth_service.dart';
import 'package:metro_ticketing_system_mobile/features/auth/logic/register_cubit.dart';
import 'package:metro_ticketing_system_mobile/features/auth/presentation/widgets/register_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstantAppColor.primaryLight,
      appBar: AppBar(title: const Text("Tạo Tài Khoản")),
      body: BlocProvider(
        create: (_) => RegisterCubit(getIt<AuthService>()),
        child: const RegisterForm(),
      ),
    );
  }
}
