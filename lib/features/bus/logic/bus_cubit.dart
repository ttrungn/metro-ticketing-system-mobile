import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../data/bus_service.dart';
import '../data/models/response/bus_model.dart';

@injectable
class BusCubit extends Cubit<BusState> {
  final BusService _busService;

  BusCubit(this._busService) : super(BusInitial());

  Future<void> fetchBuses({
    String? stationName,
    String? destinationName,
  }) async {
    emit(BusLoading());
    try {
      final buses = await _busService.getBuses(
        stationName: stationName,
        destinationName: destinationName,
      );
      emit(BusLoaded(buses));
    } catch (e) {
      emit(BusError(message: e.toString()));
    }
  }
}

abstract class BusState {}

class BusInitial extends BusState {}

class BusLoading extends BusState {}

class BusLoaded extends BusState {
  final List<BusModel> buses;
  BusLoaded(this.buses);
}

class BusError extends BusState {
  final String message;
  BusError({required this.message});
}
