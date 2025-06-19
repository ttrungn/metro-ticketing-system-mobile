

import 'package:flutter/material.dart';

import '../../../../core/constants/app_color.dart';

class BuyTicketTitleText extends StatelessWidget {
  final String title;

  const BuyTicketTitleText({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Text(title,style: TextStyle(
        fontSize: 22,color: ConstantAppColor.primary,fontWeight: FontWeight.w600,
      ),),
    );
  }
}
