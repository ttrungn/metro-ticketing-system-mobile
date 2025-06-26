

import 'package:metro_ticketing_system_mobile/features/buy_ticket/data/models/station_info.dart';

class StationsResponse{

  final List<StationInfo> stationList;
  
  StationsResponse({ required this.stationList});
  
  
  factory StationsResponse.fromJson(dynamic json){
    return StationsResponse( stationList:
        (json['data'] as List<dynamic>).map((e) => StationInfo.fromJson(e)).toList()
    );
  }
}