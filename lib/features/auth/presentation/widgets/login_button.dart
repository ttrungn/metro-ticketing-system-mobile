import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metro_ticketing_system_mobile/core/constants/app_color.dart';
import 'package:metro_ticketing_system_mobile/core/utils/dialogs.dart';
import 'package:metro_ticketing_system_mobile/features/auth/logic/login_cubit.dart';

import '../../../../core/routes/app_routes.dart';

class LoginButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool Function() onValidationRequired;

  const LoginButton({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.onValidationRequired,
  });

  List<Widget> _buildDialogActionButtons(BuildContext context) {
    return [
      TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text("Đóng"),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) async {
        if (state is LoginSuccess) {
          Navigator.pushNamed(context, AppRoutes.home);
        } else if (state is LoginFailure) {
          showCustomDialog(
            context,
            Icons.error,
            Colors.red,
            "Thất bại",
            state.message,
            _buildDialogActionButtons(context),
          );
        }
      },
      builder: (context, state) {
        if (state is LoginLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ConstantAppColor.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              // Validate all fields before attempting login
              if (onValidationRequired()) {
                context.read<LoginCubit>().login(
                  emailController.text,
                  passwordController.text,
                );
              }
            },
            child: const Text(
              "Đăng Nhập",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }
}
