import 'package:injectable/injectable.dart';
import 'package:metro_ticketing_system_mobile/features/view_ticket/data/models/response/ticket_box_info_list_response.dart';
import 'view_ticket_repository.dart';

@lazySingleton
class ViewTicketService {
  final ViewTicketRepository _repository;

  ViewTicketService(this._repository);

  Future<TicketBoxInfoListResponse> getTicketsByStatus(int status) async {
    final params = {'status': status};
    return await _repository.getListTicketByUserId(queryParams: params);
  }
}
