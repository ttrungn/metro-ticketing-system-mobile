import 'package:flutter/material.dart';

import '../../../../constants/app_color.dart';
import 'leading_ticket_icon.dart';

class TicketBox extends StatelessWidget {
  final String ticketName;
  final Widget bottomContent;
  final VoidCallback onTap;

  const TicketBox({
    super.key,
    required this.ticketName,
    required this.bottomContent,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          padding: const EdgeInsets.all(14),
          height: 90,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [BoxShadow(offset: Offset(2, 2), color: Colors.black12)],
          ),
          child: Row(
            children: [
              Expanded(flex: 1, child: LeadingTicketIcon()),
              SizedBox(width: 10),
              Expanded(
                flex: 5,
                child: TicketInformation(
                  ticketName: ticketName,
                  bottomContent: bottomContent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TicketInformation extends StatelessWidget {
  final String ticketName;
  final Widget bottomContent;

  const TicketInformation({
    super.key,
    required this.ticketName,
    required this.bottomContent,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                ticketName,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            SizedBox(width: 5),
            Expanded(
              flex: 2,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerRight,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  decoration: BoxDecoration(
                    color: ConstantAppColor.primaryLight,
                    // your custom background color
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.link_off,
                        size: 12,
                        color: Colors.blueAccent, // your primary icon color
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Not connected',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.blueAccent, // your primary text color
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
       Row(
         children: [
           bottomContent
         ],
       )
      ],
    );
  }
}
