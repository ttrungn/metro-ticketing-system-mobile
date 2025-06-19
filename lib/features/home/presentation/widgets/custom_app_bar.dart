import 'package:flutter/material.dart';
import 'package:metro_ticketing_system_mobile/features/home/presentation/widgets/profile_button.dart';
import '../../../../core/constants/app_color.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 250,
      floating: false,
      pinned: true,
      elevation: 0,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          double opacity = (1 - ((constraints.maxHeight - kToolbarHeight) / (250 - kToolbarHeight))).clamp(0.0, 1.0);
          if (opacity > 0.5) {
            opacity = 1.0;
          }
          return Stack(
            fit: StackFit.expand,
            children: [
              // Background image
              Transform.translate(
                offset: Offset(0, 30),
                child: Container(
                  alignment: Alignment.center,
                  child: Hero(
                    tag: 'logo',
                    child: Image.asset(
                      'assets/icon/metro_logo_nobg.png',
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              // Overlay color
              Container(
                color: ConstantAppColor.primary.withValues(alpha: opacity),
              ),
            ],
          );
        },
      ),
      actions: [
        ProfileButton(),
      ],
    );
  }
}
