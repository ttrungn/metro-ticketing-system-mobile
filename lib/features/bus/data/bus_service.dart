import 'package:injectable/injectable.dart';
import 'bus_repository.dart';
import 'models/response/bus_model.dart';

@lazySingleton
class BusService {
  final BusRepository _repository;

  BusService(this._repository);

  Future<List<BusModel>> getBuses({
    int page = 0,
    int pageSize = 100,
    bool status = false,
    String? stationName,
    String? destinationName,
  }) async {
    final params = <String, dynamic>{
      'page': page,
      'pageSize': pageSize,
      'status': status,
    };
    if (stationName != null && stationName.isNotEmpty) {
      params['stationName'] = stationName;
    }
    if (destinationName != null && destinationName.isNotEmpty) {
      params['destinationName'] = destinationName;
    }
    return await _repository.getBuses(queryParams: params);
  }
}
