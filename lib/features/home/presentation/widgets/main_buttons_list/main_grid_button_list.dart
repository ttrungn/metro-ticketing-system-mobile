import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/constants/app_color.dart';
import 'main_button.dart';

class MainGridButtonList extends StatelessWidget {
  const MainGridButtonList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: kGlobalHomePagePadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: ConstantAppColor.primary,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 25, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Metro Ticket System',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30,
                            color: ConstantAppColor.primary,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GridView.count(
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 1,
                    crossAxisCount: 4,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(vertical: 20),
                    children: [
                      MainButton(
                        icon: FontAwesomeIcons.ticket,
                        text: 'Mua vé',
                        onPressed: () async {
                          await Navigator.pushNamed(context, '/buy-ticket');
                        },
                      ),
                      MainButton(
                        icon: FontAwesomeIcons.train,
                        text: 'Vé của tôi',
                        onPressed: () async {
                          await Navigator.pushNamed(context, '/my-ticket');
                        },
                      ),
                      MainButton(
                        icon: Icons.feedback_rounded,
                        text: 'Đánh giá',
                        onPressed: () async {
                          await Navigator.pushNamed(context, '/feedback');
                        },
                      ),
                      MainButton(
                        icon: Icons.settings,
                        text: 'Cài đặt',
                        onPressed: () async {
                          Navigator.pushNamed(context, '/settings');
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
