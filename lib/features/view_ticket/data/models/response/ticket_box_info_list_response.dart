import 'package:flutter/cupertino.dart';

class TicketBoxInfoListResponse {
  List<TicketBoxInfo> tickets;

  TicketBoxInfoListResponse({required this.tickets});

  factory TicketBoxInfoListResponse.fromJson(Map<String, dynamic> json) {
    return TicketBoxInfoListResponse(
      tickets: (json['tickets'] as List<dynamic>)
          .map((e)=> TicketBoxInfo.fromJson(e)).toList()
    );
  }
}

class TicketBoxInfo {
  final String ticketId;
  final String name;

  final DateTime activateDate;
  final DateTime expireDate;

  TicketBoxInfo({
    required this.ticketId,
    required this.name,
    required this.activateDate,
    required this.expireDate,
  });


  factory TicketBoxInfo.fromJson(Map<String, dynamic> json){
    return TicketBoxInfo(
      ticketId: json['ticketId'],
      name: json['name'],
      activateDate: DateTime.parse(json['activateDate']),
      expireDate: DateTime.parse(json['expireDate']),
    );
  }
}
