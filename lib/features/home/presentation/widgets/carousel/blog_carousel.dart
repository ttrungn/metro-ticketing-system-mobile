import 'package:flutter/material.dart';
import 'package:metro_ticketing_system_mobile/core/constants/app_color.dart';

class BlogCarousel extends StatelessWidget {
  const BlogCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title row with "Tin tức" and "Tất cả"
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Tin tức',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                ),
                Text(
                  'Tất cả',
                  style: TextStyle(
                    fontSize: 14,
                    color: ConstantAppColor.primary,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Horizontal card list
            SizedBox(
              height: 250,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 3, //
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  return _BlogCard();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BlogCard extends StatelessWidget {
  const _BlogCard();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Blog image
            Image.asset(
              'assets/icon/playstore.png',
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ' THÔNG BÁO VỀ VIỆC ĐIỀU CHỈNH GIÁ VÉ',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Mua vé đúng thời điểm để đảm bảo quyền lợi',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
