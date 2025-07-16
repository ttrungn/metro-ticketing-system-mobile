import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metro_ticketing_system_mobile/features/buy_ticket/data/models/single_use_buyt_ticket_info.dart';
import 'package:metro_ticketing_system_mobile/features/buy_ticket/data/request/single_use_ticket_request.dart';

import '../data/buy_ticket_service.dart';
import '../data/models/route_info.dart';
import '../data/models/station_info.dart';

final class SearchRouteState {
   List<RouteInfo> routes =[];
   List<StationInfo> stations = [];


}


class SearchRouteCubit extends Cubit<SearchRouteState> {
  final BuyTicketService buyTicketService;

  SearchRouteCubit(this.buyTicketService) : super(SearchRouteState());

  void fetchRoutes() async{
    print("fetch Routes");
    var newState = SearchRouteState();
    newState.routes = await buyTicketService.getRoutes();
    newState.stations = [];
    emit(newState);
  }

  void fetchStations(String routeId) async{
    print("Fetch Stations");
    var newState = SearchRouteState();
    newState.routes = state.routes;
    newState.stations = await buyTicketService.getStationsByRouteId(routeId);
    print(newState.stations);
    emit(newState);
  }

  Future<SingleUseTicketInfo> fetchTicket(String routeId, String entryId, String exitId) async {
    var newState = SearchRouteState();
    newState.routes = state.routes;
    newState.stations = state.stations;
    emit(newState);

    return  await buyTicketService.getSingleUseTicketInfo(SingleUseTicketRequest(routeId: routeId, entryStationId: entryId, exitStationId: exitId));
  }
}

// Mock tuyến đường (Routes)
List<RouteInfo> mockRoutesVN() {
  return [
    RouteInfo(id: '1', name: 'Tuyến số 1 - Bến Thành đến Suối Tiên'),
    RouteInfo(id: '2', name: 'Tuyến số 2 - Bến Thành đến Tham Lương'),
  ];
}

// Mock trạm theo tuyến (Stations by Route)
Map<String, List<StationInfo>> mockStationsByRouteVN() {
  return {
    '1': [
      StationInfo(id: '1_s1', name: 'Bến Thành'),
      StationInfo(id: '1_s2', name: 'Nhà Hát Thành Phố'),
      StationInfo(id: '1_s3', name: 'Ba Son'),
      StationInfo(id: '1_s4', name: 'Văn Thánh'),
      StationInfo(id: '1_s5', name: 'Tân Cảng'),
      StationInfo(id: '1_s6', name: 'Thảo Điền'),
      StationInfo(id: '1_s7', name: 'An Phú'),
      StationInfo(id: '1_s8', name: 'Rạch Chiếc'),
      StationInfo(id: '1_s9', name: 'Phước Long'),
      StationInfo(id: '1_s10', name: 'Bình Thái'),
      StationInfo(id: '1_s11', name: 'Thủ Đức'),
      StationInfo(id: '1_s12', name: 'Khu Công Nghệ Cao'),
      StationInfo(id: '1_s13', name: 'Suối Tiên'),
      StationInfo(id: '1_s14', name: 'Bến Xe Miền Đông Mới'),
    ],
    '2': [
      StationInfo(id: '2_s1', name: 'Bến Thành'),
      StationInfo(id: '2_s2', name: 'Phạm Ngũ Lão'),
      StationInfo(id: '2_s3', name: 'Ngã Sáu Dân Chủ'),
      StationInfo(id: '2_s4', name: 'Ba Tháng Hai'),
      StationInfo(id: '2_s5', name: 'Công Viên Lê Thị Riêng'),
      StationInfo(id: '2_s6', name: 'Chợ Tân Bình'),
      StationInfo(id: '2_s7', name: 'Phạm Văn Bạch'),
      StationInfo(id: '2_s8', name: 'Cộng Hòa'),
      StationInfo(id: '2_s9', name: 'Hoàng Văn Thụ'),
      StationInfo(id: '2_s10', name: 'Depot Tân Bình'),
      StationInfo(id: '2_s11', name: 'Tham Lương'),
    ],
  };
}

// Mock vé lượt (Single-Use Ticket)
SingleUseTicketInfo mockSingleUseTicketVN() {
  return SingleUseTicketInfo(
    id: 'ticket_001',
    name: 'Vé lượt - Bến Thành đến Suối Tiên',
    price: 15000.0,
    expireInDays: 1,
    entryStationId: '3',
    exitStationId: '4',
    entryStationName: 'Bến Thành',
    exitStationName: 'Suối Tiên',
  );
}
