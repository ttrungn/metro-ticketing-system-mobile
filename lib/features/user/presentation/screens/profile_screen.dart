import 'package:flutter/material.dart';
import '../../../../core/constants/app_color.dart';
import '../widgets/info_tile.dart';
import 'package:metro_ticketing_system_mobile/features/student_verification/presentation/screens/verification_form_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin tài khoản'),
        backgroundColor: ConstantAppColor.primary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const InfoTile(
              icon: Icons.person,
              title: 'Họ tên',
              subtitle: 'Khánh Hoàng',
            ),
            const InfoTile(
              icon: Icons.email,
              title: 'Email',
              subtitle: 'lehoangkhanh209@gmail.com',
            ),
            InfoTile(
              icon: Icons.credit_card,
              title: 'Số CCCD/Căn Cước',
              subtitle: 'Chưa cập nhật',
              showTrailing: true,
              onTap: () {
                // TODO: update CCCD
              },
            ),
            InfoTile(
              icon: Icons.account_balance,
              title: 'Thẻ thanh toán',
              subtitle: 'Sacombank Mastercard Metro Pass',
              showTrailing: true,
              onTap: () {
                // Check payment card details
              },
            ),
            InfoTile(
              icon: Icons.payment,
              title: 'Quản lý phương thức thanh toán',
              subtitle: 'VNPay',
              showTrailing: true,
              onTap: () {
                // Manage payment methods
              },
            ),
            InfoTile(
              icon: Icons.verified_user,
              title: 'Xác thực sinh viên',
              subtitle: 'Chưa xác thực',
              showTrailing: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const VerificationFormScreen(),
                  ),
                );
              },
            ),
            const Divider(),
            InfoTile(
              iconColor: Colors.red,
              titleColor: Colors.red,
              icon: Icons.delete_forever,
              title: 'Xoá tài khoản',
              onTap: () {
                // Confirm delete
              },
            ),
            InfoTile(
              iconColor: Colors.red,
              titleColor: Colors.red,
              icon: Icons.logout,
              title: 'Đăng xuất',
              onTap: () {
                // Logout user
              },
            ),
          ],
        ),
      ),
    );
  }
}
