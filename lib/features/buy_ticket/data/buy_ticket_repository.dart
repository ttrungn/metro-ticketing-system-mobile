import 'package:injectable/injectable.dart';
import 'package:metro_ticketing_system_mobile/core/configs/api_client.dart';
import 'package:metro_ticketing_system_mobile/features/buy_ticket/data/models/buy_ticket_box_info_response.dart';

@lazySingleton
class BuyTicketRepository {
  BuyTicketRepository();

  Future<BuyTicketBoxInfoResponse> getBuyTickets() async {
    try{
      var response = await ApiClient.dio.get(
        "/catalog/Tickets/"
      );
      print(response);
      print(response.data);
      return BuyTicketBoxInfoResponse.fromJson(response.data as List<dynamic>);
    }catch(e){

      throw("Get Buy Tickets error: $e");
    }
  }
}
