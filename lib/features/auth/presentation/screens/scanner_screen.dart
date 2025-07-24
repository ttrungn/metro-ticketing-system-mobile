import 'package:flutter/material.dart';
import 'package:metro_ticketing_system_mobile/core/constants/app_color.dart';
import 'package:metro_ticketing_system_mobile/features/scan_qr_code/presentation/screens/scan_qr_code_exit_screen.dart';
import 'package:metro_ticketing_system_mobile/features/scan_qr_code/presentation/screens/scan_qr_code_screen.dart';
import 'login_screen.dart';

class ScannerScreen extends StatelessWidget {
  const ScannerScreen({super.key});
  void _handleBack(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false,
    );
  }
  Widget _buildScanButton({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        elevation: 4,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    size: 32,
                    color: color,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey[400],
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          _handleBack(context);
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => _handleBack(context),
            ),
            title: const Text(
              'Quét Mã QR',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
          ),
      body: Container(
        color: Colors.grey[100],
        child: Column(
          children: [
            const SizedBox(height: 20),
            Image.asset(
              'assets/icon/metro_logo_nobg.png',
              height: 120,
            ),
            const SizedBox(height: 30),
            _buildScanButton(
              title: 'Quét Mã Vào',
              subtitle: 'Sử dụng để quét mã khi vào ga',
              icon: Icons.qr_code_scanner,
              color: ConstantAppColor.primary,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ScanQRCodeScreen(),
                ),
              ),
            ),
            _buildScanButton(
              title: 'Quét Mã Ra',
              subtitle: 'Sử dụng để quét mã khi ra ga',
              icon: Icons.qr_code_2,
              color: Colors.orange,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ScanQRCodeExitScreen(),
                ),
              ),
            ),
          ],
        ),
      ),
        ),
    );
  }
}