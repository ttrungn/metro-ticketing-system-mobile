

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metro_ticketing_system_mobile/features/view_ticket/data/models/response/ticket_box_info_list_response.dart';

abstract class ViewTicketState{

}


class ViewTicketUnused extends ViewTicketState{
  List<TicketBoxInfo>? unusedTickets;

  ViewTicketUnused({this.unusedTickets});
}

class ViewTicketInUse extends ViewTicketState{
  List<TicketBoxInfo>? usedTickets;
  ViewTicketInUse({this.usedTickets});
}


class ViewTicketCubit extends Cubit<ViewTicketState>{
  ViewTicketCubit():super(ViewTicketUnused(unusedTickets: MockData.getMockTickets(false).tickets));

  void toggleUnusedBtn(){
    final tickets = MockData.getMockTickets(false);
    print(tickets);// Get UNUSED tickets
    emit(ViewTicketUnused(unusedTickets: tickets.tickets));
  }

  void toggleUsedBtn(){
    final tickets = MockData.getMockTickets(true);
    print(tickets);// Get USED tickets
    emit(ViewTicketInUse(usedTickets: tickets.tickets));
  }

}


class MockData {
  static TicketBoxInfoListResponse getMockTickets(bool isUsed) {
    if (isUsed) {
      return TicketBoxInfoListResponse(
        tickets: [
          TicketBoxInfo(
            ticketId: 'TKT001',
            name: 'Vé 1 chiều: Ga Đại Học Quốc Gia đến Ga Bến Thành (Đã sử dụng)',
            activateDate: DateTime(2025, 6, 26, 23, 59),
            expireDate: DateTime(2025, 6, 27, 23, 59),
          ),
          TicketBoxInfo(
            ticketId: 'TKT002',
            name: 'Vé khứ hồi: Ga Sài Gòn đến Ga Hà Nội (Đã sử dụng)',
            activateDate: DateTime(2025, 6, 25, 8, 0),
            expireDate: DateTime(2025, 6, 26, 20, 0),
          ),
        ],
      );
    } else {
      return TicketBoxInfoListResponse(
        tickets: [
          TicketBoxInfo(
            ticketId: 'TKT003',
            name: 'Vé 1 chiều: Ga Tân Sơn Nhất đến Ga Suối Tiên (Chưa sử dụng)',
            activateDate: DateTime(2025, 7, 1, 7, 30),
            expireDate: DateTime(2025, 7, 1, 18, 0),
          ),
          TicketBoxInfo(
            ticketId: 'TKT004',
            name: 'Vé 1 chiều: Ga Bến Thành đến Ga Suối Tiên (Chưa sử dụng)',
            activateDate: DateTime(2025, 2, 1, 7, 30),
            expireDate: DateTime(2025, 2, 1, 18, 0),
          ),
        ],
      );
    }
  }
}