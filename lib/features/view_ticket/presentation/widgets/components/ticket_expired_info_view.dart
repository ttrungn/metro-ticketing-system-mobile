import 'package:flutter/material.dart';
import '../../../../../core/constants/app_color.dart';
import 'ticket_info_body.dart';

class TicketExpiredInfoView extends StatelessWidget {
  final String ticketName;
  final String ticketId;
  final String? entryStationName;
  final String? destinationStationName;
  final int status;
  final DateTime? activateDate;
  final DateTime? expireDate;
  final int ticketType;

  const TicketExpiredInfoView({
    super.key,
    required this.ticketName,
    required this.ticketId,
    required this.status,
    required this.entryStationName,
    required this.destinationStationName,
    required this.activateDate,
    required this.expireDate,
    required this.ticketType,
  });

  @override
  Widget build(BuildContext context) {

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.blueGrey.shade100, width: 2),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.train, color: ConstantAppColor.primary),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    _ticketRouteText(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: ConstantAppColor.primaryLight,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: ConstantAppColor.primary),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
              margin: const EdgeInsets.only(top: 4, bottom: 5),
              child: TicketInfoBody(
                ticketId: ticketId,
                status: status,
                entryStationName: entryStationName,
                destinationStationName: destinationStationName,
                activateDate: activateDate,
                expireDate: expireDate,
                ticketType: ticketType,
                ticketName: ticketName,
              ),
            ),
          ],
        ),
      ),
    );
  }
  String _ticketRouteText() {
    if (entryStationName == null || destinationStationName == null) {
      return ticketName;
    }
    return '$ticketName: $entryStationName - $destinationStationName';
  }
}
