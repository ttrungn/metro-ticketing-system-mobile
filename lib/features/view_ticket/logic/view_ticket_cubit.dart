
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metro_ticketing_system_mobile/features/view_ticket/data/models/response/ticket_box_info_list_response.dart';
import '../data/view_ticket_service.dart';
abstract class ViewTicketState{}

class ViewTicketInitial extends ViewTicketState {}

class ViewTicketLoading extends ViewTicketState {}

class ViewTicketUnused extends ViewTicketState{
  List<TicketBoxInfo>? unusedTickets;

  ViewTicketUnused({required this.unusedTickets});
}

class ViewTicketInUse extends ViewTicketState{
  List<TicketBoxInfo>? usedTickets;
  ViewTicketInUse({required  this.usedTickets});
}
class ViewTicketExpire extends ViewTicketState{
  List<TicketBoxInfo>? expiredTickets;
  ViewTicketExpire({required  this.expiredTickets});
}

class ViewTicketError extends ViewTicketState {
  final String message;

  ViewTicketError({required this.message});
}

class ViewTicketCubit extends Cubit<ViewTicketState>{
  final ViewTicketService _ticketService;
  bool isInUseSelected = true;

  ViewTicketCubit(this._ticketService) : super(ViewTicketInitial());

  void toggleUsedBtn() async {
    isInUseSelected = true;
    await getUsedTickets();
  }

  void toggleUnusedBtn() async {
    isInUseSelected = false;
    await getUnusedTickets();
  }

  Future<void> getUnusedTickets() async {
    emit(ViewTicketLoading());

    try {
      final response = await _ticketService.getTicketsByStatus(0); // Unused
      emit(ViewTicketUnused(unusedTickets: response.tickets));
    } catch (e) {
      emit(ViewTicketError(message: e.toString()));
    }
  }

  Future<void> getUsedTickets() async {
    emit(ViewTicketLoading());

    try {
      final response = await _ticketService.getTicketsByStatus(1); // Used
      emit(ViewTicketInUse(usedTickets: response.tickets));
    } catch (e) {
      emit(ViewTicketError(message: e.toString()));
    }
  }
  Future<void> getExpiredTickets() async {
    emit(ViewTicketLoading());

    try {
      final response = await _ticketService.getTicketsByStatus(2); // Expired
      emit(ViewTicketExpire(expiredTickets: response.tickets));
    } catch (e) {
      emit(ViewTicketError(message: e.toString()));
    }
  }
}