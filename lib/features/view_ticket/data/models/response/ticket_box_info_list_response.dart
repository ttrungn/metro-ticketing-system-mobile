import 'package:flutter/cupertino.dart';

class TicketBoxInfoListResponse {
  List<TicketBoxInfo> tickets;

  TicketBoxInfoListResponse({required this.tickets});

  factory TicketBoxInfoListResponse.fromJson(Map<String, dynamic> json) {
    return TicketBoxInfoListResponse(
      tickets: (json['data'] as List<dynamic>)
          .map((e)=> TicketBoxInfo.fromJson(e)).toList()
    );
  }
}

class TicketBoxInfo {
  final String? id;
  final String ticketId;
  final String ticketName;
  final DateTime activateDate;
  final DateTime expireDate;
  final String? entryStationName;
  final String? destinationStationName;
  final int? status;
  final int ticketType;

  TicketBoxInfo({
    this.id,
    required this.ticketId,
    required this.ticketName,
    required this.activateDate,
    required this.expireDate,
    this.entryStationName,
    this.destinationStationName,
    this.status,
    required this.ticketType,
  });


  factory TicketBoxInfo.fromJson(Map<String, dynamic> json){
    return TicketBoxInfo(
      id: json['id'],
      ticketId: json['ticketId'],
      ticketName: json['ticketName'] ?? 'Vé không tên',
      activateDate: DateTime.parse(json['activeAt']),
      expireDate: DateTime.parse(json['expiredAt']),
      entryStationName: json['entryStationName'],
      destinationStationName: json['destinationStationName'],
      status: json['status'],
      ticketType: json['ticketType'] ?? 0,
    );
  }
}
