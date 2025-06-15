import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metro_ticketing_system_mobile/core/constants/app_color.dart';
import 'package:metro_ticketing_system_mobile/features/user/logic/user_cubit.dart';
import 'package:metro_ticketing_system_mobile/features/user/presentation/widgets/info_tile.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({super.key});

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserError) {
            return Center(child: Text('Lỗi: ${state.message}'));
          } else if (state is UserLoaded) {
            final user = state.userInfo;
            return SingleChildScrollView(
              child: Column(
                children: [
                  InfoTile(
                    icon: Icons.person,
                    title: 'Họ tên',
                    subtitle: user.name ?? 'Chưa cập nhật',
                  ),
                  InfoTile(
                    icon: Icons.email,
                    title: 'Email',
                    subtitle: user.email ?? 'Chưa cập nhật',
                  ),
                  InfoTile(
                    icon: Icons.school,
                    title: 'Sinh viên',
                    subtitle: user.isStudent ?? 'Chưa cập nhật',
                  ),
                  InfoTile(
                    icon: Icons.delete,
                    title: 'Xóa tài khoản',
                    onTap: () {
                      // Handle account deletion logic here
                    },
                  ),
                  const Divider(
                    color: ConstantAppColor.primary,
                    thickness: 1,
                    height: 30,
                  ),
                  InfoTile(
                    icon: Icons.logout,
                    title: 'Đăng xuất',
                    iconColor: Colors.red,
                    titleColor: Colors.red,
                    onTap: () {
                      // Handle logout logic here
                    },
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
