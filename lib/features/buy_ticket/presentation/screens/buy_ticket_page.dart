import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metro_ticketing_system_mobile/core/common/presentation/modals/dialog_utils.dart';
import 'package:metro_ticketing_system_mobile/core/common/presentation/widgets/ticket_widgets/custom_ticket_app_bar.dart';
import 'package:metro_ticketing_system_mobile/core/common/presentation/widgets/ticket_widgets/ticket_box.dart';
import 'package:metro_ticketing_system_mobile/features/buy_ticket/logic/buy_ticket_cubit.dart';
import 'package:metro_ticketing_system_mobile/features/buy_ticket/presentation/widgets/buy_ticket_body.dart';

import '../../../../core/constants/app_color.dart';

const screenTitle = "Mua Vé";

class BuyTicketPage extends StatelessWidget {
  const BuyTicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BuyTicketCubit()..fetchBuyTickets(),
      child: Scaffold(
        backgroundColor: ConstantAppColor.primary,
        body: Column(
          children: [
            CustomTicketAppBar(title: screenTitle),
            Expanded(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  decoration: BoxDecoration(
                    color: ConstantAppColor.primaryLight,
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(40)),
                  ),
                  child: BuyTicketBody(),
              ),
            )
            ,
          ],
        ),
      ),);
  }
}
