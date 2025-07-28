import 'package:flutter/material.dart';
import 'package:metro_ticketing_system_mobile/core/constants/app_color.dart';
import 'package:metro_ticketing_system_mobile/features/home/presentation/widgets/Carousel/metro_info_card.dart';

class InfoCarousel extends StatelessWidget {
  const InfoCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: kGlobalHomePagePadding,
          vertical: 30,
        ),
        height: 300,
        child: CarouselView(
          itemExtent: 300,
          shrinkExtent: 300.0,
          children: [MetroInfoCard(), MetroInfoCard(), MetroInfoCard()],
        ),
      ),
    );
  }
}
