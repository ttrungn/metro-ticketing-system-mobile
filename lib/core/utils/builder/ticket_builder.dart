

import '../../../features/buy_ticket/data/models/dto/buy_ticket_info.dart';

class TicketBuilder{
   static List<Map<String, dynamic>> buildTicketDetailItems(BuyTicketInfo ticket) {
    return [
      {
        'label': 'Ticket type:',
        'value': ticket.name,
        'isNote': false,
      },
      {
        'label': 'Expiration:',
        'value': '${ticket.activeInDay} days after activation',
        'isNote': false,
      },
      {
        'label': 'Note:',
        'value': 'Auto activate after 30 days',
        'isNote': true,
      },
      {
        'label': 'Price:',
        'value': '${ticket.price.toStringAsFixed(0)} đ',
        'isNote': false,
      },
    ];
  }
}