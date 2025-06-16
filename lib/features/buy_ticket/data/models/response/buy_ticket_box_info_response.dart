import 'dart:convert';

import '../dto/buy_ticket_info.dart';

class BuyTicketBoxInfoResponse {
  List<BuyTicketInfo> buyTickets;

  BuyTicketBoxInfoResponse({required this.buyTickets});


  factory BuyTicketBoxInfoResponse.fromJson(Map<String, dynamic> json){
    return BuyTicketBoxInfoResponse(buyTickets:
    (json['buy-tickets'] as List<dynamic>).map((e) => BuyTicketInfo.fromJson(e)).toList()
    );
  }
}


