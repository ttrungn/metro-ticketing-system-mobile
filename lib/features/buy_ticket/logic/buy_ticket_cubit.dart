

import 'dart:core';

import 'package:flutter_bloc/flutter_bloc.dart';

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

class BuyTicketCubit extends Cubit<BuyTicketState>{
  BuyTicketCubit():super(BuyTicketLoading());

  void fetchBuyTickets(){
    emit(BuyTicketLoading());

    //mock api loading
    Future.delayed(Duration(seconds: 1));
    List<BuyTicketInfo> sortedList = getMockData().toList()
      ..sort((a, b) => a.type.index.compareTo(b.type.index));
    emit(BuyTicketFetch(buyTickets: sortedList));

  }
}

List<BuyTicketInfo> getMockData() {
  return [
    BuyTicketInfo(
      id: 'T001',
      name: 'Vé 1 chiều',
      price: 0,
      expireInDay: 30,
      activeInDay: 0,
      type: TicketType.singleUse,
    ),
    BuyTicketInfo(
      id: 'T002',
      name: 'Vé 1 ngày',
      price: 40000.0,
      expireInDay: 30,
      activeInDay: 1,
      type: TicketType.multipleUse,
    ),
    BuyTicketInfo(
      id: 'T003',
      name: 'Vé 3 ngày',
      price: 90000.0,
      expireInDay: 90,
      activeInDay: 3,
      type: TicketType.multipleUse,
    ),
    BuyTicketInfo(
      id: 'T004',
      name: 'Vé tháng',
      price: 300000.0,
      expireInDay: 180,
      activeInDay: 30,
      type: TicketType.multipleUse,
    ),
    BuyTicketInfo(
      id: 'T005',
      name: 'Vé tháng HSSV',
      price: 200000.0,
      expireInDay: 180,
      activeInDay: 30,
      type: TicketType.student,
    ),
  ];
}


