import 'package:flutter/material.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/routes/app_routes.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.profile);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: (ConstantAppColor.primary),
          minimumSize: Size.zero,
          padding: EdgeInsets.zero,
          shape: CircleBorder(),
        ),
        child: const Icon(
          Icons.account_circle_outlined,
          size: 40,
          color: Colors.white,
        ),
      ),
    );
  }
}
