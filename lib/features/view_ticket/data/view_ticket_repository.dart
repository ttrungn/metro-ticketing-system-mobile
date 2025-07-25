
import 'package:injectable/injectable.dart';
import 'package:metro_ticketing_system_mobile/core/configs/api_client.dart';
import 'package:metro_ticketing_system_mobile/features/view_ticket/data/models/response/ticket_box_info_list_response.dart';

@lazySingleton
class ViewTicketRepository {
  ViewTicketRepository();


  Future<TicketBoxInfoListResponse> getListTicketByUserId({Map<String,dynamic>? queryParams}) async{
    try {
      final response = await ApiClient.dio.get("/order/Orders", queryParameters: queryParams);
      final data = response.data;
      return TicketBoxInfoListResponse.fromJson(response.data);
    } on Exception catch (e) {
      throw Exception("Failed to load tickets: $e");
    }
  }

}