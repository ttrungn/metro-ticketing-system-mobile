import 'package:flutter/material.dart';
import 'package:metro_ticketing_system_mobile/core/common/presentation/widgets/global_loading_overlay.dart';
import 'package:metro_ticketing_system_mobile/features/home/presentation/widgets/Carousel/blog_carousel.dart';
import 'package:metro_ticketing_system_mobile/features/home/presentation/widgets/custom_app_bar.dart';
import 'package:metro_ticketing_system_mobile/features/home/presentation/widgets/main_buttons_list/main_grid_button_list.dart';
import 'package:metro_ticketing_system_mobile/features/home/presentation/widgets/phone_button.dart';

import '../widgets/Carousel/info_carousel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalLoadingOverlay(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: CustomScrollView(
          slivers: [
            CustomAppBar(),
            MainGridButtonList(),
            InfoCarousel(),
            BlogCarousel()
          ],
        ),
        floatingActionButton: PhoneButton(),
      ),
    );
  }
}
