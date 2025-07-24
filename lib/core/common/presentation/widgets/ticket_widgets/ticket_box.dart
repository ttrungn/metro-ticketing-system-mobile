import 'package:flutter/material.dart';

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
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 4,
            vertical: 6,
          ), // Reduced horizontal margin for full width
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ), // Increased padding for better content spacing
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 2),
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const LeadingTicketIcon(),
              const SizedBox(width: 16), // Increased spacing
              Expanded(
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
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Ticket name with full display
        Text(
          ticketName,
          overflow: TextOverflow.visible,
          maxLines: null, // Allow unlimited lines
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 8),
        // Bottom content with full display
        DefaultTextStyle(
          style: const TextStyle(fontSize: 13, color: Colors.grey, height: 1.2),
          child: bottomContent,
        ),
      ],
    );
  }
}
