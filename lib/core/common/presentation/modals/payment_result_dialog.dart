import 'package:flutter/material.dart';

class PaymentResultDialog extends StatelessWidget {
  final bool isSuccess;

  const PaymentResultDialog({super.key, required this.isSuccess});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Icon(
            isSuccess ? Icons.check_circle : Icons.error,
            color: isSuccess ? Colors.green : Colors.red,
          ),
          SizedBox(width: 8),
          Text(isSuccess ? 'Thành công' : 'Thất bại'),
        ],
      ),
      content: Text(
        isSuccess ? "Mua vé Thành Công" : "Bạn không thể mua vé này!",
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('OK'),
        ),
      ],
    );
  }
}
