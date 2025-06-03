import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metro_ticketing_system_mobile/core/constants/app_color.dart';
import 'package:metro_ticketing_system_mobile/core/routes/app_routes.dart';
import 'package:metro_ticketing_system_mobile/core/utils/dialogs.dart';
import 'package:metro_ticketing_system_mobile/features/auth/logic/register_cubit.dart';

class RegisterButton extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool Function() onValidationRequired;

  const RegisterButton({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.onValidationRequired,
  });

  List<Widget> _buildSuccessDialogActionButtons(BuildContext context) {
    return [
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ConstantAppColor.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () {
          Navigator.of(context).pop(); // Close dialog
          Navigator.pushNamed(context, AppRoutes.login);
        },
        child: const Text('Đăng Nhập'),
      ),
    ];
  }

  List<Widget> _buildErrorDialogActionButtons(BuildContext context) {
    return [
      TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text("Đóng"),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          showCustomDialog(
            context,
            Icons.check_circle,
            ConstantAppColor.primary,
            'Thành công',
            'Tài khoản của bạn đã được tạo thành công!',
            _buildSuccessDialogActionButtons(context),
          );
        } else if (state is RegisterFailure) {
          showCustomDialog(
            context,
            Icons.error,
            Colors.red,
            "Thất bại",
            state.message,
            _buildErrorDialogActionButtons(context),
          );
        }
      },
      builder: (context, state) {
        if (state is RegisterLoading) {
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
              if (onValidationRequired()) {
                context.read<RegisterCubit>().register(
                  firstName: firstNameController.text,
                  lastName: lastNameController.text,
                  email: emailController.text,
                  password: passwordController.text,
                );
              }
            },
            child: const Text(
              "Đăng ký",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }
}
