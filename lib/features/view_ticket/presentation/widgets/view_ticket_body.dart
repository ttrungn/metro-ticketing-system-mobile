import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:metro_ticketing_system_mobile/features/view_ticket/data/models/response/ticket_box_info_list_response.dart';
import 'package:metro_ticketing_system_mobile/features/view_ticket/presentation/widgets/components/ticket_toggle_panel.dart';

import '../../../../core/common/presentation/widgets/ticket_widgets/ticket_box.dart';
import '../../../../core/constants/app_color.dart';
import '../../logic/view_ticket_cubit.dart';
import 'components/ticket_qr_view.dart';

class ViewTicketBody extends StatelessWidget {
  const ViewTicketBody({super.key});

  String _ticketRouteText(TicketBoxInfo ticket) {
    if (ticket.entryStationName == null || ticket.destinationStationName == null) {
      return ticket.ticketName;
    }
    return '${ticket.ticketName}: ${ticket.entryStationName} - ${ticket.destinationStationName}';
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: ConstantAppColor.primaryLight,
          borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        ),
        child: Column(
          children: [
            TicketTogglePanel(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: BlocBuilder<ViewTicketCubit, ViewTicketState>(
                  builder: (context, state) {
                    var tickets = [];
                    final isInUseSelected = context.read<ViewTicketCubit>().isInUseSelected;
                    if (state is ViewTicketInUse) {
                      tickets = state.usedTickets as List<TicketBoxInfo>;
                    }
                    if (state is ViewTicketUnused) {
                      tickets = state.unusedTickets as List<TicketBoxInfo>;
                    }
                    if (tickets.isEmpty) {
                      return const Center(
                        child: Text(
                          "Bạn không có vé nào",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                        ),
                      );
                    }
                    return ListView.builder(
                      padding: EdgeInsets.only(bottom: 25),
                      itemCount: tickets.length,
                      itemBuilder: (context, index) {
                        final ticket = tickets[index];
                        final ticketName = ticket.ticketName;
                        final entryStation = ticket.entryStationName ?? '';
                        final exitStation = ticket.destinationStationName ?? '';
                        final DateTime? activateDate = ticket.activateDate;
                        final DateTime? expireDate = ticket.expireDate;
                        final int status = ticket.status;
                        final int ticketType = ticket.ticketType;
                        // --- Alternative way to format the date manually ---
                        final String formattedActivateDate =
                            activateDate != null
                                ? '${activateDate.hour.toString().padLeft(2, '0')}:'
                                    '${activateDate.minute.toString().padLeft(2, '0')} '
                                    '${activateDate.day.toString().padLeft(2, '0')}/'
                                    '${activateDate.month.toString().padLeft(2, '0')}/'
                                    '${activateDate.year}'
                                : 'N/A';

                        final String formattedExpiredAtDate =
                        expireDate != null
                            ? '${expireDate.hour.toString().padLeft(2, '0')}:'
                            '${expireDate.minute.toString().padLeft(2, '0')} '
                            '${expireDate.day.toString().padLeft(2, '0')}/'
                            '${expireDate.month.toString().padLeft(2, '0')}/'
                            '${expireDate.year}'
                            : 'N/A';
                        final bool isActivated = activateDate != null && activateDate.isBefore(DateTime.now());
                        final String activationText = isActivated ? 'Đã Kích hoạt: $formattedActivateDate' : 'Tự động kích hoạt: $formattedActivateDate';
                        final String bottomText = isInUseSelected
                            ? 'HSD: $formattedExpiredAtDate'
                            : activationText;

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: TicketBox(
                            ticketName: _ticketRouteText(ticket),
                            bottomContent: Text(
                              overflow: TextOverflow.ellipsis,
                              bottomText,
                              style: TextStyle(
                                fontSize: 17,
                                color: ConstantAppColor.primary,
                              ),
                            ),
                            onTap: () {
                              final ticketId = tickets[index].ticketId;
                              final id = tickets[index].id;
                            print("Tap on ticket $ticketId");
                              print("Tap on ticket $id");
                            showDialog(
                              context: context,

                              builder: (_) => TicketQRView(
                                ticketId: ticketId,
                                orderId: id,
                                ticketName: ticketName,
                                entryStationName: entryStation,
                                destinationStationName: exitStation,
                                activateDate: activateDate,
                                expireDate: expireDate,
                                status: status,
                                ticketType: ticketType,
                              ),
                            );
                          },
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
