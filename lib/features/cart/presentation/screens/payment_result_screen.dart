import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metro_ticketing_system_mobile/core/constants/app_color.dart';
import 'package:metro_ticketing_system_mobile/core/routes/app_routes.dart';
import 'package:metro_ticketing_system_mobile/features/cart/logic/payment_cubit.dart';
import '../../data/model/momo_payment_query.dart';
import '../../data/model/payment_result.dart';


class PaymentResultScreen extends StatelessWidget {
  final PaymentResult result;

  const PaymentResultScreen({
    super.key,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    final isSuccess = result.isConfirm;
    final icon = isSuccess ? Icons.check_circle : Icons.error;
    final color = isSuccess ? Colors.green : Colors.red;
    final message = isSuccess
        ? 'THANH TOÁN ${result.ticketCount} VÉ THÀNH CÔNG'
        : 'THANH TOÁN THẤT BẠI';

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, AppRoutes.home);
        return false;
      },
      child: Scaffold(
        backgroundColor: ConstantAppColor.primaryLight,
        appBar: AppBar(
          backgroundColor: ConstantAppColor.primary,
          title: const Text(
            'Payment Result',
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacementNamed(context, AppRoutes.home);
            },
          ),
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
                    Navigator.pushReplacementNamed(context, AppRoutes.home);
                  },
                  child: const Text('Back'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}