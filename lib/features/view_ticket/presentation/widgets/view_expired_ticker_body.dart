import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metro_ticketing_system_mobile/core/constants/app_color.dart';
import 'package:metro_ticketing_system_mobile/core/common/presentation/widgets/ticket_widgets/ticket_box.dart';
import 'package:metro_ticketing_system_mobile/features/view_ticket/data/models/response/ticket_box_info_list_response.dart';
import '../../logic/view_ticket_cubit.dart';
import 'components/ticket_expired_info_view.dart';
class ViewExpiredTicketBody extends StatelessWidget {
  const ViewExpiredTicketBody({super.key});

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
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: ConstantAppColor.primaryLight,
          borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        ),
        child: BlocBuilder<ViewTicketCubit, ViewTicketState>(
          builder: (context, state) {
            if (state is ViewTicketExpire) {
              final tickets = state.expiredTickets ?? [];

              return ListView.builder(
                padding: const EdgeInsets.only(top: 25),
                itemCount: tickets.length,
                itemBuilder: (context, index) {
                  final ticket = tickets[index];
                  final name = ticket.ticketName;
                  final expiredDate = ticket.expireDate;
                  final formattedDate = expiredDate != null
                      ? '${expiredDate.hour.toString().padLeft(2, '0')}:${expiredDate.minute.toString().padLeft(2, '0')} '
                      '${expiredDate.day.toString().padLeft(2, '0')}/${expiredDate.month.toString().padLeft(2, '0')}/${expiredDate.year}'
                      : 'N/A';

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: TicketBox(
                      ticketName:
                      _ticketRouteText(ticket),
                      bottomContent: Text(
                        'HSD: $formattedDate',
                        style: const TextStyle(
                          fontSize: 17,
                          color: ConstantAppColor.primary,
                        ),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => TicketExpiredInfoView(
                            ticketName: ticket.ticketName,
                            ticketId: ticket.ticketId,
                            entryStationName: ticket.entryStationName,
                            destinationStationName: ticket.destinationStationName,
                            status: 2,
                            activateDate: ticket.activateDate,
                            expireDate: ticket.expireDate,
                            ticketType: ticket.ticketType,
                          ),
                        );
                      },

                    ),
                  );
                },
              );
            }

            if (state is ViewTicketLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return const Center(child: Text("Bạn Không Có Vé Nào."));
          },
        ),
      ),
    );
  }

}
