import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:metro_ticketing_system_mobile/core/constants/ticket/buy_ticket_const.dart';
import 'package:metro_ticketing_system_mobile/core/utils/builder/ticket_builder.dart';
import 'package:metro_ticketing_system_mobile/features/buy_ticket/data/request/add_to_cart_request.dart';
import 'package:metro_ticketing_system_mobile/features/buy_ticket/presentation/widgets/buy_button.dart';
import 'package:metro_ticketing_system_mobile/features/buy_ticket/presentation/widgets/buy_ticket_title_text.dart';
import 'package:metro_ticketing_system_mobile/features/buy_ticket/presentation/widgets/search_route_body.dart';

import '../../../../core/common/presentation/modals/dialog_utils.dart';
import '../../../../core/common/presentation/widgets/ticket_widgets/ticket_box.dart';
import '../../../../core/constants/app_color.dart';
import '../../data/models/buy_ticket_info.dart';
import '../../logic/buy_ticket_cubit.dart';
import 'buy_ticket_dialog_bottom_part.dart';

class BuyTicketBody extends StatefulWidget {
  const BuyTicketBody({super.key});

  @override
  State<BuyTicketBody> createState() => _BuyTicketBodyState();
}

class _BuyTicketBodyState extends State<BuyTicketBody> {
  int _currentValue = 1;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<BuyTicketCubit, BuyTicketState>(
        builder: (context, state) {
          if (state is BuyTicketLoading) {
            return SizedBox(
              height: 100,
              width: double.infinity,
              child: Center(
                child: SpinKitCubeGrid(
                  size: 70,
                  color: ConstantAppColor.primary,
                  duration: Duration(milliseconds: 350),
                ),
              ),
            );
          } else if (state is BuyTicketFetch) {
            final tickets = state.buyTickets;
            // Separate into normal and student tickets
            final normalTickets =
                tickets.where((t) => t.type != TicketType.student).toList();
            final studentTickets =
                tickets.where((t) => t.type == TicketType.student).toList();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BuyTicketTitleText(title: ConstantBuyTicket.buyTitle),
                ...normalTickets.map(
                  (ticket) => TicketBox(
                    ticketName: ticket.name,
                    bottomContent: Text(
                      ticket.price == 0
                          ? ConstantBuyTicket.oneWayTicketBottomText
                          : '${currencyFormatter.format(ticket.price)} đ',
                      style: TextStyle(
                        fontSize: 17,
                        color:
                            ticket.price == 0
                                ? Colors.redAccent
                                : ConstantAppColor.primary,
                        fontWeight:
                            ticket.price == 0
                                ? FontWeight.w600
                                : FontWeight.normal,
                      ),
                    ),
                    onTap: () {
                      if (ticket.type == TicketType.singleUse) {
                        context.read<BuyTicketCubit>().switchToSearchRoute();
                      } else if (ticket.type == TicketType.multipleUse) {
                        DialogUtils.buildAndShowBuyTicketDialogAction(
                          context: context,
                          ticketDetails:
                              TicketBuilder.buildMultiUseBuyTicketDetailItems(ticket),
                          bottomPart:  BuyTicketDialogBottomPart(
                            currentValue: _currentValue,
                            onPressed: () async{
                              print("BUY TICKET");
                              print("Cubit from context: ${context.read<BuyTicketCubit>().hashCode}");

                              var quantity = _currentValue;
                              var ticketId = ticket.id;
                              var request = AddToCartRequest(ticketId: ticketId, quantity: quantity);
                              await context.read<BuyTicketCubit>().addToCart(request);
                            },
                            onChangedQuantity: (value) {
                              setState(() {
                                _currentValue = value;
                              });

                            },
                          ) ,
                        )();
                      }
                    },
                  ),
                ),
                if (studentTickets.isNotEmpty)
                  BuyTicketTitleText(
                    title: ConstantBuyTicket.studentTicketTitle,
                  ),
                ...studentTickets.map(
                  (ticket) => TicketBox(
                    ticketName: ticket.name,
                    bottomContent: Text(
                      '${ticket.price.toStringAsFixed(0)} đ',
                      style: TextStyle(
                        fontSize: 17,
                        color: ConstantAppColor.primary,
                      ),
                    ),
                    onTap: DialogUtils.buildAndShowBuyTicketDialogAction(
                      context: context,
                      ticketDetails: TicketBuilder.buildMultiUseBuyTicketDetailItems(
                        ticket,
                      ),
                      bottomPart:  BuyTicketDialogBottomPart(
                        currentValue: _currentValue,
                        onPressed: () async{
                          print("BUY TICKET");
                          var quantity = _currentValue;
                          var ticketId = ticket.id;

                          var request = AddToCartRequest(ticketId: ticketId, quantity: quantity);
                          await context.read<BuyTicketCubit>().addToCart(request);
                        },
                        onChangedQuantity: (value) {
                          setState(() {
                            _currentValue = value;
                          });
                        },
                      ) ,
                    ),
                  ),
                ),
                const SizedBox(height: 200),
              ],
            );
          } else if (state is BuyTicketSearchRoute) {
            return SearchRouteBody();
          } else {
            return const Center(child: Text("No tickets available"));
          }
        },
      ),
    );
  }
}



typedef IconEntry = DropdownMenuEntry<IconLabel>;

enum IconLabel {
  smile('Smile', Icons.sentiment_satisfied_outlined),
  cloud('Cloud', Icons.cloud_outlined),
  brush('Brush', Icons.brush_outlined),
  heart('Heart', Icons.favorite);

  const IconLabel(this.label, this.icon);

  final String label;
  final IconData icon;

  static final List<IconEntry> entries = UnmodifiableListView<IconEntry>(
    values.map<IconEntry>(
      (IconLabel icon) => IconEntry(
        value: icon,
        label: icon.label,
        leadingIcon: Icon(icon.icon),
      ),
    ),
  );
}
