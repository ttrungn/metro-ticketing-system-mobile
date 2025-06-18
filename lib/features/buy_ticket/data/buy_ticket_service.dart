
import 'package:injectable/injectable.dart';

import 'buy_ticket_repository.dart';
import 'models/dto/buy_ticket_info.dart';

@lazySingleton
class BuyTicketService{
  final BuyTicketRepository _repo;
  BuyTicketService(this._repo);

  Future<List<BuyTicketInfo>> getBuyTickets() async{
    var response = await _repo.getBuyTickets();
    return response.buyTickets;
  }
}