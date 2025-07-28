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
    if (ticket.entryStationName == null ||
        ticket.destinationStationName == null) {
      return ticket.ticketName;
    }
    return '${ticket.ticketName}: ${ticket.entryStationName} - ${ticket.destinationStationName}';
  }

  /// Formats DateTime to readable string
  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return 'N/A';
    return '${dateTime.hour.toString().padLeft(2, '0')}:'
        '${dateTime.minute.toString().padLeft(2, '0')} '
        '${dateTime.day.toString().padLeft(2, '0')}/'
        '${dateTime.month.toString().padLeft(2, '0')}/'
        '${dateTime.year}';
  }

  /// Builds individual ticket item
  Widget _buildTicketItem(
    BuildContext context,
    TicketBoxInfo ticket,
    int index,
    List<TicketBoxInfo> tickets,
  ) {
    final ticketName = ticket.ticketName;
    final entryStation = ticket.entryStationName ?? '';
    final exitStation = ticket.destinationStationName ?? '';
    final DateTime activateDate = ticket.activateDate;
    final DateTime expireDate = ticket.expireDate;
    final int status = ticket.status ?? 2; // Status 2 for expired
    final int ticketType = ticket.ticketType;

    // Format date for expired tickets
    final String formattedExpiredDate = _formatDateTime(expireDate);
    final String bottomText = 'Đã sử dụng: $formattedExpiredDate';

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      child: TicketBox(
        ticketName: _ticketRouteText(ticket),
        bottomContent: Text(
          bottomText,
          overflow: TextOverflow.visible, // Allow full display
          maxLines: null, // Allow unlimited lines
          style: TextStyle(
            fontSize: 13,
            color: ConstantAppColor.primary,
            fontWeight: FontWeight.w500,
            height: 1.3,
          ),
        ),
        onTap:
            () => _showTicketExpiredInfo(
              context,
              ticket,
              ticketName,
              entryStation,
              exitStation,
              activateDate,
              expireDate,
              status,
              ticketType,
            ),
      ),
    );
  }

  /// Shows ticket expired info dialog
  void _showTicketExpiredInfo(
    BuildContext context,
    TicketBoxInfo ticket,
    String ticketName,
    String entryStation,
    String exitStation,
    DateTime? activateDate,
    DateTime? expireDate,
    int status,
    int ticketType,
  ) {
    showDialog(
      context: context,
      builder:
          (_) => TicketExpiredInfoView(
            ticketName: ticketName,
            ticketId: ticket.ticketId,
            entryStationName: entryStation.isEmpty ? null : entryStation,
            destinationStationName: exitStation.isEmpty ? null : exitStation,
            status: status,
            activateDate: activateDate,
            expireDate: expireDate,
            ticketType: ticketType,
          ),
    );
  }

  /// Builds the empty state widget for expired tickets
  Widget _buildEmptyExpiredState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history, size: 64, color: Colors.grey.withOpacity(0.5)),
          const SizedBox(height: 16),
          Text(
            "Không có vé hết hạn",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: ConstantAppColor.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            "Các vé đã hết hạn sẽ hiển thị ở đây",
            style: TextStyle(fontSize: 14, color: ConstantAppColor.textLight),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(
          top: 20,
        ), // Added margin for curved effect
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
        ), // Reduced padding for wider tickets
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: ConstantAppColor.primaryLight,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(
              30,
            ), // Added back border radius for curved effect
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, -2),
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          children: [
            const SizedBox(height: 8),
            // Drag indicator
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            // Ticket list
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color:
                      ConstantAppColor.primaryLight, // Ensure same background
                ),
                child: BlocBuilder<ViewTicketCubit, ViewTicketState>(
                  builder: (context, state) {
                    if (state is ViewTicketExpire) {
                      final tickets = state.expiredTickets ?? [];

                      if (tickets.isEmpty) {
                        return _buildEmptyExpiredState();
                      }

                      return ListView.separated(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 0,
                          vertical: 0,
                        ), // Removed vertical padding
                        itemCount: tickets.length,
                        separatorBuilder:
                            (context, index) => const SizedBox(
                              height: 12,
                            ), // Spacing between tickets
                        itemBuilder: (context, index) {
                          final ticket = tickets[index];
                          return _buildTicketItem(
                            context,
                            ticket,
                            index,
                            tickets,
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
            ),
            // Add bottom padding for home indicator
          ],
        ),
      ),
    );
  }
}
