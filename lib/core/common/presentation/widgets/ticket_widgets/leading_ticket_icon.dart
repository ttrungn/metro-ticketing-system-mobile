import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../constants/app_color.dart';

class LeadingTicketIcon extends StatelessWidget {
  const LeadingTicketIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: ConstantAppColor.primaryLight,
      ),
      child: Icon(
        FontAwesomeIcons.ticket,
        color: ConstantAppColor.primary,
        size: 30,
      ),
    );
  }
}
