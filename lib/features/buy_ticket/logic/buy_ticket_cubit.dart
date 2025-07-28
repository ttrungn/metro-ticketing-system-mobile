import 'dart:core';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metro_ticketing_system_mobile/features/buy_ticket/data/buy_ticket_service.dart';
import 'package:metro_ticketing_system_mobile/features/buy_ticket/data/models/single_use_buyt_ticket_info.dart';
import 'package:metro_ticketing_system_mobile/features/buy_ticket/data/request/add_to_cart_request.dart';

import '../data/models/buy_ticket_info.dart';

abstract class BuyTicketState {}

final class BuyTicketLoading extends BuyTicketState {}

final class BuyTicketFetch extends BuyTicketState {
  List<BuyTicketInfo> buyTickets;

  BuyTicketFetch({required this.buyTickets});
}

final class BuyTicketSearchRoute extends BuyTicketState {
  SingleUseTicketInfo singleUseTicket;

  BuyTicketSearchRoute(this.singleUseTicket);
}

final class BuyTicketSuccess extends BuyTicketState {}

final class BuyTicketError extends BuyTicketState {}

class BuyTicketCubit extends Cubit<BuyTicketState> {
  final BuyTicketService buyTicketService;
  BuyTicketCubit(this.buyTicketService) : super(BuyTicketLoading());

  void fetchBuyTickets() async {
    emit(BuyTicketLoading());

    //mock api loading
    List<BuyTicketInfo> sortedList =
        await buyTicketService.getBuyTickets()
          ..sort((a, b) => a.type.index.compareTo(b.type.index));

    emit(BuyTicketFetch(buyTickets: sortedList));
  }

  void switchToSearchRoute() async {
    emit(BuyTicketLoading());
    await Future.delayed(Duration(milliseconds: 300));

    emit(BuyTicketSearchRoute(mockSingleUseTicket));
  }

  Future<bool> addToCart(AddToCartRequest request) async {
    var isStudent = await buyTicketService.addToCart(request);
    return isStudent;
  }
}

final SingleUseTicketInfo mockSingleUseTicket = SingleUseTicketInfo(
  id: '0001',
  name: 'Vé Lượt',
  price: 15000.0,
  expireInDays: 10,
  entryStationId: '3',
  exitStationId: '4',
  entryStationName: 'Bến Thành',
  exitStationName: 'Suối Tiên',
);
