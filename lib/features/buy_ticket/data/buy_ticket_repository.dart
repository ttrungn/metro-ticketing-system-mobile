import 'dart:convert';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:metro_ticketing_system_mobile/core/configs/api_client.dart';
import 'package:metro_ticketing_system_mobile/features/buy_ticket/data/models/buy_ticket_box_info_response.dart';
import 'package:metro_ticketing_system_mobile/features/buy_ticket/data/models/routes_response.dart';
import 'package:metro_ticketing_system_mobile/features/buy_ticket/data/models/single_use_buyt_ticket_info.dart';
import 'package:metro_ticketing_system_mobile/features/buy_ticket/data/models/stations_response.dart';
import 'package:metro_ticketing_system_mobile/features/buy_ticket/data/request/add_to_cart_request.dart';
import 'package:metro_ticketing_system_mobile/features/buy_ticket/data/request/single_use_ticket_request.dart';

@lazySingleton
class BuyTicketRepository {
  BuyTicketRepository();

  Future<BuyTicketBoxInfoResponse> getBuyTickets() async {
    try {
      var response = await ApiClient.dio.get("/catalog/Tickets/");
      print(response);
      print(response.data);
      return BuyTicketBoxInfoResponse.fromJson(response.data as List<dynamic>);
    } catch (e) {
      throw ("Get Buy Tickets error: $e");
    }
  }

  Future<RoutesResponse> getRoutes() async {
    try {
      var response = await ApiClient.dio.get(
        "/catalog/Routes/single-use-route",
      );
      return RoutesResponse.fromJson(response.data['data'] as List<dynamic>);
    } catch (e) {
      throw ("Get Routes error: $e");
    }
  }

  Future<StationsResponse> getStationsByRouteId(String routeId) async {
    try {
      var response = await ApiClient.dio.get(
        "/catalog/Stations/single-use-station/$routeId",
      );
      return StationsResponse.fromJson(response.data);
    } catch (e) {
      throw ("Get Stations By RouteId error: $e");
    }
  }

  Future<SingleUseTicketInfo> getSingleUseTicketInfo(
    SingleUseTicketRequest request,
  ) async {

    try {
      var response = await ApiClient.dio.post(
        "/catalog/Tickets/single-use-ticket-info",

        data: request.toJson(),
      );
      return SingleUseTicketInfo.fromJson(response.data['data']);
    } catch (e) {
      throw ("Get Single Use Ticket Info error: $e");
    }
  }

  Future<bool> addToCart(AddToCartRequest request) async{
    try{
      var response = await ApiClient.dio.post(
        "/order/Cart/",
        data: request.toJson(),
      );
      print(response.data);

      return (response.data['data']['isStudent']) as bool;
    }catch(e){

      throw ("Add To Cart error: $e");
    }finally{
    }
  }
}
