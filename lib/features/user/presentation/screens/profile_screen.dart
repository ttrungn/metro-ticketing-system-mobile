import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metro_ticketing_system_mobile/core/di/service_locator.dart';
import 'package:metro_ticketing_system_mobile/features/user/data/user_service.dart';
import 'package:metro_ticketing_system_mobile/features/user/logic/user_cubit.dart';
import 'package:metro_ticketing_system_mobile/features/user/presentation/widgets/profile_form.dart';
import '../../../../core/constants/app_color.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin tài khoản'),
        backgroundColor: ConstantAppColor.primary,
      ),
      body: BlocProvider(
        create: (_) => UserCubit(getIt<UserService>())..getUserInfo(),
        child: const ProfileForm(),
      ),
    );
  }
}