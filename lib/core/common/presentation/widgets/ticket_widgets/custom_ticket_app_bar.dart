import 'package:flutter/material.dart';
import 'package:metro_ticketing_system_mobile/core/constants/app_color.dart';

class CustomTicketAppBar extends StatelessWidget {
  final String title;
  final Widget? leftWidget;

  const CustomTicketAppBar({super.key, required this.title, this.leftWidget});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SafeArea(
          child: SizedBox(
            height: 56,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    title,
                    style: TextStyle(
                      color: ConstantAppColor.primaryLight,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.home_outlined,
                      color: ConstantAppColor.primaryLight,
                      size: 40,
                    ),
                  ),
                ),
                Positioned(
                  right: 16,
                  child: leftWidget ?? Container(),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 180,
          decoration: BoxDecoration(
            color: ConstantAppColor.primary,
            image: DecorationImage(
              image: AssetImage('assets/banners/test_transparent.png'),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }
}
