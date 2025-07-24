import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metro_ticketing_system_mobile/features/view_ticket/data/models/response/ticket_box_info_list_response.dart';
import 'package:metro_ticketing_system_mobile/features/view_ticket/presentation/widgets/components/ticket_toggle_panel.dart';

import '../../../../core/common/presentation/widgets/ticket_widgets/ticket_box.dart';
import '../../../../core/constants/app_color.dart';
import '../../logic/view_ticket_cubit.dart';
import 'components/ticket_qr_view.dart';

class ViewTicketBody extends StatelessWidget {
  const ViewTicketBody({super.key});

  String _ticketRouteText(TicketBoxInfo ticket) {
    if (ticket.entryStationName == null ||
        ticket.destinationStationName == null) {
      return ticket.ticketName;
    }
    return '${ticket.ticketName}: ${ticket.entryStationName} - ${ticket.destinationStationName}';
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
            const SizedBox(height: 12),
            // Toggle panel
            const TicketTogglePanel(),
            const SizedBox(height: 8),
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
                    var tickets = <TicketBoxInfo>[];
                    final isInUseSelected =
                        context.read<ViewTicketCubit>().isInUseSelected;

                    if (state is ViewTicketInUse) {
                      tickets = state.usedTickets ?? [];
                    }
                    if (state is ViewTicketUnused) {
                      tickets = state.unusedTickets ?? [];
                    }

                    if (tickets.isEmpty) {
                      return _buildEmptyState(isInUseSelected);
                    }

                    return _buildTicketList(context, tickets, isInUseSelected);
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

  /// Builds the empty state widget
  Widget _buildEmptyState(bool isInUseSelected) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isInUseSelected
                ? Icons.confirmation_number_outlined
                : Icons.schedule,
            size: 64,
            color: Colors.grey.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            isInUseSelected
                ? "Không có vé đang sử dụng"
                : "Không có vé chưa sử dụng",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: ConstantAppColor.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            isInUseSelected
                ? "Các vé đã kích hoạt sẽ hiển thị ở đây"
                : "Các vé chưa kích hoạt sẽ hiển thị ở đây",
            style: TextStyle(fontSize: 14, color: ConstantAppColor.textLight),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Builds the ticket list
  Widget _buildTicketList(
    BuildContext context,
    List<TicketBoxInfo> tickets,
    bool isInUseSelected,
  ) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(
        horizontal: 0,
        vertical: 0,
      ), // Removed vertical padding
      itemCount: tickets.length,
      separatorBuilder:
          (context, index) =>
              const SizedBox(height: 2), // Increased spacing back to 12
      itemBuilder: (context, index) {
        final ticket = tickets[index];
        return _buildTicketItem(
          context,
          ticket,
          isInUseSelected,
          index,
          tickets,
        );
      },
    );
  }

  /// Builds individual ticket item
  Widget _buildTicketItem(
    BuildContext context,
    TicketBoxInfo ticket,
    bool isInUseSelected,
    int index,
    List<TicketBoxInfo> tickets,
  ) {
    final ticketName = ticket.ticketName;
    final entryStation = ticket.entryStationName ?? '';
    final exitStation = ticket.destinationStationName ?? '';
    final DateTime? activateDate = ticket.activateDate;
    final DateTime? expireDate = ticket.expireDate;
    final int status = ticket.status ?? 0;
    final int ticketType = ticket.ticketType;

    // Format dates
    final String formattedActivateDate = _formatDateTime(activateDate);
    final String formattedExpiredAtDate = _formatDateTime(expireDate);

    final bool isActivated =
        activateDate != null && activateDate.isBefore(DateTime.now());
    final String activationText =
        isActivated
            ? 'Đã kích hoạt: $formattedActivateDate'
            : 'Tự động kích hoạt: $formattedActivateDate';
    final String bottomText =
        isInUseSelected ? 'HSD: $formattedExpiredAtDate' : activationText;

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
            () => _showTicketQR(
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

  /// Formats DateTime to readable string
  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return 'N/A';
    return '${dateTime.hour.toString().padLeft(2, '0')}:'
        '${dateTime.minute.toString().padLeft(2, '0')} '
        '${dateTime.day.toString().padLeft(2, '0')}/'
        '${dateTime.month.toString().padLeft(2, '0')}/'
        '${dateTime.year}';
  }

  /// Shows ticket QR dialog
  void _showTicketQR(
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
    final ticketId = ticket.ticketId;
    final id = ticket.id;

    print("Tap on ticket $ticketId");
    print("Tap on ticket $id");

    showDialog(
      context: context,
      builder:
          (_) => TicketQRView(
            ticketId: ticketId,
            orderId: id ?? '',
            ticketName: ticketName,
            entryStationName: entryStation,
            destinationStationName: exitStation,
            activateDate: activateDate,
            expireDate: expireDate,
            status: status,
            ticketType: ticketType,
          ),
    );
  }
}
