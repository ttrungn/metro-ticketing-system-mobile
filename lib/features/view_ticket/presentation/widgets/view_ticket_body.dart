


import 'package:flutter/material.dart';
import 'package:metro_ticketing_system_mobile/features/view_ticket/presentation/widgets/components/ticket_toggle_panel.dart';

import '../../../../core/constants/app_color.dart';

class ViewTicketBody extends StatelessWidget {
  const ViewTicketBody({super.key});

  @override
  Widget build(BuildContext context) {
    return  Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: ConstantAppColor.primaryLight,
          borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        ),
        child: SingleChildScrollView(

            child: Column(
              children: [
                TicketTogglePanel(),
              ],
            ),
        ),
      ),
    );
  }
}
