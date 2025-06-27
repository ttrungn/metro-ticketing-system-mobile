import 'dart:convert';

import 'buy_ticket_info.dart';

class BuyTicketBoxInfoResponse {
  List<BuyTicketInfo> buyTickets;

  BuyTicketBoxInfoResponse({required this.buyTickets});


  factory BuyTicketBoxInfoResponse.fromJson(List<dynamic> json){
    return BuyTicketBoxInfoResponse(buyTickets:
    json.map((e) => BuyTicketInfo.fromJson(e)).toList()
    );
  }
}


