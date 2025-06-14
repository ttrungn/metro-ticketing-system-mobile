import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metro_ticketing_system_mobile/core/constants/ticket/buy_ticket_const.dart';
import 'package:metro_ticketing_system_mobile/core/utils/builder/ticket_builder.dart';
import 'package:metro_ticketing_system_mobile/features/buy_ticket/presentation/widgets/buy_button.dart';
import 'package:metro_ticketing_system_mobile/features/buy_ticket/presentation/widgets/buy_ticket_title_text.dart';
import 'package:metro_ticketing_system_mobile/features/buy_ticket/presentation/widgets/ticket_dialog_content.dart';


import '../../../../core/common/presentation/modals/dialog_utils.dart';
import '../../../../core/common/presentation/widgets/ticket_widgets/ticket_box.dart';
import '../../../../core/constants/app_color.dart';
import '../../data/models/dto/buy_ticket_info.dart';
import '../../logic/buy_ticket_cubit.dart';

class BuyTicketBody extends StatelessWidget {
  const BuyTicketBody({super.key});




  VoidCallback buildBuyTicketDialogAction(BuildContext context, BuyTicketInfo ticket) {
    if (ticket.type == TicketType.singleUse){
      // Navigator.pushNamed(context, routeName)
    }

    return () {
      DialogUtils.showCustomDialog(
        context,
        okBtnFunction: () => Navigator.pop(context),
        childBuilder: () => TicketDialogContent(
          ticketDetails: TicketBuilder.buildTicketDetailItems(ticket),
        ), bottomPart: BuyButton(),
      );
    };
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<BuyTicketCubit, BuyTicketState>(
        builder: (context, state) {
          if (state is BuyTicketLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BuyTicketFetch) {
            final tickets = state.buyTickets;
            // Separate into normal and student tickets
            final normalTickets = tickets.where((t) => t.type != TicketType.student).toList();
            final studentTickets = tickets.where((t) => t.type == TicketType.student).toList();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BuyTicketTitleText(title: ConstantBuyTicket.topTitle),
                ...normalTickets.map((ticket) => TicketBox(
                  ticketName: ticket.name,
                  bottomContent: Text(
                    ticket.price == 0
                        ? ConstantBuyTicket.oneWayTicketBottomText
                        : '${ticket.price.toStringAsFixed(0)} đ',
                    style: TextStyle(
                      fontSize: 17,
                      color: ticket.price == 0
                          ? Colors.redAccent
                          : ConstantAppColor.primary,
                      fontWeight: ticket.price == 0 ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                  onTap: buildBuyTicketDialogAction(context,ticket)
                )),

                if (studentTickets.isNotEmpty)
                  BuyTicketTitleText(title: ConstantBuyTicket.studentTicketTitle),

                ...studentTickets.map((ticket) => TicketBox(
                  ticketName: ticket.name,
                  bottomContent: Text(
                    '${ticket.price.toStringAsFixed(0)} đ',
                    style: TextStyle(
                      fontSize: 17,
                      color: ConstantAppColor.primary,
                    ),
                  ),
                    onTap: buildBuyTicketDialogAction(context,ticket)
                )),

                const SizedBox(height: 200),
              ],
            );
          } else {
            return const Center(child: Text("No tickets available"));
          }
        },
      ),
    );
  }
}
