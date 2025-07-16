import 'package:flutter/material.dart';
import 'package:metro_ticketing_system_mobile/core/constants/app_color.dart';
import 'package:metro_ticketing_system_mobile/core/routes/app_routes.dart';

class PaymentResultScreen extends StatelessWidget {
  final String? orderId;
  final String? resultCode;

  const PaymentResultScreen({
    super.key,
     this.orderId = "abc",
     this.resultCode = "0",
  });

  @override
  Widget build(BuildContext context) {
    final isSuccess = resultCode == '0';
    final icon = isSuccess ? Icons.check_circle : Icons.cancel;
    final message = isSuccess ? 'Payment Successful' : 'Payment Failed';
    final color = isSuccess ? ConstantAppColor.primary : Colors.red;

    return Scaffold(
      backgroundColor: ConstantAppColor.primaryLight,
      appBar: AppBar(
        backgroundColor: ConstantAppColor.primary,
        title: const Text(
          'Payment Result',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 100, color: color),
              const SizedBox(height: 20),
              Text(
                message,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 10),

              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ConstantAppColor.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 12,
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.myTicket);
                },
                child: const Text('Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
