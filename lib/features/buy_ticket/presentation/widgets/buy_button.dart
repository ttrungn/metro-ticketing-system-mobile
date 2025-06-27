
import 'package:flutter/material.dart';

import '../../../../core/constants/app_color.dart';

class BuyButton extends StatelessWidget {
  final VoidCallback onPressed;

  const BuyButton({required this.onPressed,super.key});
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
          overlayColor: WidgetStatePropertyAll(Colors.white.withAlpha(25)),
          backgroundColor: WidgetStatePropertyAll(ConstantAppColor.primary),
          shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              )
          )
      ),
      child:  Text("💸 Mua Liền! 💸",
        style: TextStyle(
          fontWeight: FontWeight.w800,
          color: Colors.white,
          fontSize: 25,
        ),

      ),
    );
  }
}