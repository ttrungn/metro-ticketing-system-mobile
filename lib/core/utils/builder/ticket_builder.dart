import 'package:metro_ticketing_system_mobile/core/constants/ticket/buy_ticket_const.dart';
import 'package:metro_ticketing_system_mobile/features/buy_ticket/data/models/single_use_buyt_ticket_info.dart';

import '../../../features/buy_ticket/data/models/buy_ticket_info.dart';

class TicketBuilder {
  static List<Map<String, dynamic>> buildMultiUseBuyTicketDetailItems(
    BuyTicketInfo ticket,
  ) {
    return [
      {'label': 'Loại Vé:', 'value': ticket.name, 'isNote': false},
      {
        'label': 'Hết Hạn:',
        'value': '${ticket.expireInDay} days after activation',
        'isNote': false,
      },
      {
        'label': 'Lưu ý:',
        'value': 'Auto activate after ${ticket.activeInDay} days',
        'isNote': true,
      },
      {
        'label': 'Giá:',
        'value': '${currencyFormatter.format(ticket.price).toString()} đ',
        'isNote': false,
      },
    ];
  }

  static List<Map<String, dynamic>> buildSingleUseBuyTicketDetailItems(
    SingleUseTicketInfo ticket,
  ) {
    return [
      {'label': 'Loại:', 'value': ticket.name, 'isNote': false},
      {
        'label': 'Ga Đi:',
        'value': ticket.entryStationName ?? 'N/A',
        'isNote': false,
      },
      {
        'label': 'Ga Đến:',
        'value': ticket.exitStationName ?? 'N/A',
        'isNote': false,
      },
      {
        'label': 'Hết Hạn:',
        'value': '${ticket.expireInDays} days after activation',
        'isNote': true,
      },
      {
        'label': 'Giá:',
        'value': '${currencyFormatter.format(ticket.price).toString()} đ',
        'isNote': false,
      },
    ];
  }
}
