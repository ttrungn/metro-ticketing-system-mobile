import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/constants/app_color.dart';

class TicketBox extends StatelessWidget {
  final String ticketName;
  final String activateDate;

  const TicketBox({
    super.key,
    required this.ticketName,
    required this.activateDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
              activateDate: activateDate,
            ),
          ),
        ],
      ),
    );
  }
}

class LeadingTicketIcon extends StatelessWidget {
  const LeadingTicketIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: ConstantAppColor.primaryLight,
      ),
      child: Icon(
        FontAwesomeIcons.ticket,
        color: ConstantAppColor.primary,
        size: 30,
      ),
    );
  }
}

class TicketInformation extends StatelessWidget {
  final String ticketName;
  final String activateDate;

  const TicketInformation({
    super.key,
    required this.ticketName,
    required this.activateDate,
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
            Text(
              'Tự động kích hoạt: ${activateDate}',
              style: TextStyle(fontSize: 15, color: ConstantAppColor.primary),
            ),
          ],
        ),
      ],
    );
  }
}
