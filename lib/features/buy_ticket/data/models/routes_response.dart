


import 'package:metro_ticketing_system_mobile/features/buy_ticket/data/models/route_info.dart';

class RoutesResponse
{
  List<RouteInfo> routes;


  RoutesResponse({required this.routes});

  factory RoutesResponse.fromJson(List<dynamic> json){
    return RoutesResponse(routes:
      json.map((e) => RouteInfo.fromJson(e)).toList()
    );
  }

}