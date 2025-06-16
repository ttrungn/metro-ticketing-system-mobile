import 'package:flutter/material.dart';
import 'package:metro_ticketing_system_mobile/core/constants/ticket/buy_ticket_const.dart';

class TicketDialogContent extends StatelessWidget {
  final List<Map<String, dynamic>> ticketDetails;
  final double? contentWidth;
  final double? contentHeight;

  const TicketDialogContent({
    super.key,
    required this.ticketDetails,
    this.contentWidth,
    this.contentHeight,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: contentWidth ?? MediaQuery.of(context).size.width * ConstantTicketDialog.buyWidth,
      height: contentHeight ?? MediaQuery.of(context).size.height * ConstantTicketDialog.buyHeight,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: ticketDetails.length,
        itemBuilder: (context, index) {
          final detail = ticketDetails[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    detail['label'],
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: detail['isNote'] ? Colors.red : Colors.black,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: Text(
                    detail['value'],
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                      color: detail['isNote'] ? Colors.red : Colors.black.withAlpha(150),
                      fontWeight: FontWeight.w600

                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
