

import 'dart:core';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metro_ticketing_system_mobile/features/buy_ticket/data/buy_ticket_service.dart';

import '../data/models/dto/buy_ticket_info.dart';
import '../data/models/response/buy_ticket_box_info_response.dart';

abstract class BuyTicketState {

}
final class BuyTicketInitial extends BuyTicketState{

}


final class BuyTicketLoading extends BuyTicketState{

}
final class BuyTicketFetch extends BuyTicketState{
  List<BuyTicketInfo> buyTickets;

  BuyTicketFetch({required this.buyTickets});
}

final class BuyTicketSearchRoute extends BuyTicketState{

}

class BuyTicketCubit extends Cubit<BuyTicketState>{
  final BuyTicketService buyTicketService;
  BuyTicketCubit(this.buyTicketService):super(BuyTicketLoading());

  void fetchBuyTickets() async{
    emit(BuyTicketLoading());

    //mock api loading
    List<BuyTicketInfo> sortedList = await buyTicketService.getBuyTickets()..sort(
      (a, b) => a.type.index.compareTo(b.type.index),
    );
    emit(BuyTicketFetch(buyTickets: sortedList));

  }
  void switchToSearchRoute() async{
    emit(BuyTicketLoading());
    await Future.delayed(Duration(milliseconds: 300));

    emit(BuyTicketSearchRoute());
  }
}


