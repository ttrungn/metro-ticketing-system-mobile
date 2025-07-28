import 'package:flutter/material.dart';

import 'package:metro_ticketing_system_mobile/core/common/presentation/widgets/ticket_widgets/leading_ticket_icon.dart';

class CartTicketBox extends StatelessWidget {
  final String ticketName;
  final Widget bottomContent;
  final VoidCallback onTap;
  final VoidCallback? onRemove;

  const CartTicketBox({
    super.key,
    required this.ticketName,
    required this.bottomContent,
    required this.onTap,
    this.onRemove,
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
          padding: const EdgeInsets.all(10),
          height: 116,
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
                  onRemove: onRemove,
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
  final VoidCallback? onRemove;

  const TicketInformation({
    super.key,
    required this.ticketName,
    required this.bottomContent,
    this.onRemove,
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
            IconButton(
              icon: Icon(Icons.close, color: Colors.red),
              onPressed: onRemove,
            ),
          ],
        ),
        Align(alignment: Alignment.centerRight, child: bottomContent),
      ],
    );
  }
}
