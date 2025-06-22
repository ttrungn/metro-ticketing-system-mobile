

import 'package:metro_ticketing_system_mobile/features/buy_ticket/data/models/station_info.dart';

class StationsResponse{
  final String routeId;
  
  final List<StationInfo> stationList;
  
  StationsResponse({required this.routeId, required this.stationList});
  
  
  factory StationsResponse.fromJson(Map<dynamic,dynamic>json){
    return StationsResponse(routeId: json['routeId'], stationList:
        (json['stations'] as List<dynamic>).map((e) => StationInfo.fromJson(e)).toList()
    );
  }
}