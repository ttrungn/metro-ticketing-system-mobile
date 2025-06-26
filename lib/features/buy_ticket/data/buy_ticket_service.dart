
import 'package:injectable/injectable.dart';
import 'package:metro_ticketing_system_mobile/features/buy_ticket/data/models/route_info.dart';
import 'package:metro_ticketing_system_mobile/features/buy_ticket/data/models/single_use_buyt_ticket_info.dart';
import 'package:metro_ticketing_system_mobile/features/buy_ticket/data/models/station_info.dart';
import 'package:metro_ticketing_system_mobile/features/buy_ticket/data/models/stations_response.dart';
import 'package:metro_ticketing_system_mobile/features/buy_ticket/data/request/single_use_ticket_request.dart';

import 'buy_ticket_repository.dart';
import 'models/buy_ticket_info.dart';

@lazySingleton
class BuyTicketService{
  final BuyTicketRepository _repo;
  BuyTicketService(this._repo);

  Future<List<BuyTicketInfo>> getBuyTickets() async{
    var response = await _repo.getBuyTickets();
    return response.buyTickets;
  }

  Future<List<RouteInfo>> getRoutes() async{
    var response = await _repo.getRoutes();
    return response.routes;
  }
  Future<List<StationInfo>> getStationsByRouteId(String routeId) async{
    var response = await _repo.getStationsByRouteId(routeId);
    return response.stationList;
  }

  Future<SingleUseTicketInfo> getSingleUseTicketInfo(SingleUseTicketRequest request) async{
    var response = await _repo.getSingleUseTicketInfo(request);
    return response;
  }
}