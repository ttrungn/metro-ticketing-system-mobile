import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:metro_ticketing_system_mobile/core/constants/ticket/buy_ticket_const.dart';
import 'package:metro_ticketing_system_mobile/core/utils/builder/ticket_builder.dart';
import 'package:metro_ticketing_system_mobile/features/buy_ticket/presentation/widgets/buy_button.dart';
import 'package:metro_ticketing_system_mobile/features/buy_ticket/presentation/widgets/buy_ticket_title_text.dart';
import 'package:metro_ticketing_system_mobile/features/buy_ticket/presentation/widgets/custom_drop_down.dart';

import '../../../../core/common/presentation/modals/dialog_utils.dart';
import '../../../../core/common/presentation/widgets/ticket_widgets/ticket_box.dart';
import '../../../../core/constants/app_color.dart';
import '../../data/models/dto/buy_ticket_info.dart';
import '../../logic/buy_ticket_cubit.dart';

class BuyTicketBody extends StatefulWidget {
  const BuyTicketBody({super.key});

  @override
  State<BuyTicketBody> createState() => _BuyTicketBodyState();
}

class _BuyTicketBodyState extends State<BuyTicketBody> {
  IconLabel? selectedIcon;
  var routeController = TextEditingController();
  var entryStationController = TextEditingController();
  var exitStationController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    routeController.dispose();
    entryStationController.dispose();
    exitStationController.dispose();
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
                              TicketBuilder.buildBuyTicketDetailItems(ticket),
                          bottomPart: BuyButton(),
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
                      ticketDetails: TicketBuilder.buildBuyTicketDetailItems(
                        ticket,
                      ),
                      bottomPart: BuyButton(),
                    ),
                  ),
                ),
                const SizedBox(height: 200),
              ],
            );
          } else if (state is BuyTicketSearchRoute) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListTile(
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back_sharp,
                      size: 30,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      context.read<BuyTicketCubit>().fetchBuyTickets();
                    },
                  ),
                  title: Text(
                    ConstantBuyTicket.searchRouteTicket,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 30,
                      color: ConstantAppColor.primary,
                    ),
                  ),
                ),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final boxSizeWidth = constraints.maxWidth * 0.9;

                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 30,
                      ),
                      margin: EdgeInsets.all(30),
                      width: boxSizeWidth,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(-4, -4),
                            color: Colors.black12,
                            blurRadius: 5,
                          ),
                          BoxShadow(
                            offset: Offset(4, 4),
                            color: Colors.black12,
                            blurRadius: 5,
                          ),
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: Column(
                        children: [
                          CustomDropDown(
                            textController: routeController,
                            icon: Icon(
                              Icons.train,
                              size: 30,
                              color: ConstantAppColor.primary,
                            ),
                            labelText: Text(
                              'Tuyến',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            dropDownList: [
                              DropdownMenuEntry(value: "haha", label: "haha"),
                              DropdownMenuEntry(value: "hehe", label: "hehe"),
                              DropdownMenuEntry(
                                value: "hihi",
                                label: "Trieu Zee",
                              ),
                            ],
                            customWidth:
                                MediaQuery.of(context).size.width * 0.9,
                            onChanged: (value){

                            },
                          ),
                          SizedBox(height: 20),
                          IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Left Icon Column with vertical stroke
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.pin_drop_outlined,
                                      color: ConstantAppColor.primary,
                                      size: 30,
                                    ),
                                    Container(
                                      width: 2,
                                      height: 40,
                                      // adjust spacing between dropdowns
                                      color:
                                          ConstantAppColor
                                              .primary, // stroke color
                                    ),
                                    Icon(
                                      Icons.pin_drop_outlined,
                                      color: ConstantAppColor.primary,
                                      size: 30,
                                    ),
                                  ],
                                ),

                                SizedBox(width: 8),

                                // Right Column for Dropdowns
                                Expanded(
                                  child: Column(
                                    children: [
                                      CustomDropDown(
                                        textController: entryStationController,
                                        labelText: Text(
                                          'Ga Đến',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        dropDownList: [
                                          DropdownMenuEntry(
                                            value: "haha",
                                            label: "haha",
                                          ),
                                          DropdownMenuEntry(
                                            value: "hehe",
                                            label: "hehe",
                                          ),
                                          DropdownMenuEntry(
                                            value: "hihi",
                                            label: "Trieu Zee",
                                          ),
                                        ],
                                        customWidth: MediaQuery.of(context).size.width * 0.7,
                                        onChanged: (value) {
                                          // TODO: handle selection change for entry station
                                        },
                                      )
                                      ,
                                      SizedBox(height: 30),
                                      CustomDropDown(
                                        textController: exitStationController,
                                        labelText: Text(
                                          'Ga Dừng',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        dropDownList: [
                                          DropdownMenuEntry(
                                            value: "haha",
                                            label: "haha",
                                          ),
                                          DropdownMenuEntry(
                                            value: "hehe",
                                            label: "hehe",
                                          ),
                                          DropdownMenuEntry(
                                            value: "hihi",
                                            label: "Trieu Zee",
                                          ),
                                        ],
                                        customWidth: MediaQuery.of(context).size.width * 0.7,
                                        onChanged: (value) {
                                          // TODO: handle selection change for exit station
                                        },
                                      )
                                      ,
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          TextButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              shadowColor: WidgetStatePropertyAll(
                                Colors.black12,
                              ),
                              backgroundColor: WidgetStatePropertyAll(
                                ConstantAppColor.primary,
                              ),
                              overlayColor: WidgetStatePropertyAll(
                                Colors.white.withAlpha(25),
                              ),
                              shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                            child: Text(
                              " Mua Liền! ",
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
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
