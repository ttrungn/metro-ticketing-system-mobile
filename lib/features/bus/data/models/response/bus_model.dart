import '../../../domain/entities/bus.dart';

class BusModel extends Bus {
  BusModel({
    required String id,
    required String code,
    required String stationId,
    required String stationName,
    required String destinationName,
    required DateTime createdAt,
  }) : super(
         id: id,
         code: code,
         stationId: stationId,
         stationName: stationName,
         destinationName: destinationName,
         createdAt: createdAt,
       );

  factory BusModel.fromJson(Map<String, dynamic> json) {
    return BusModel(
      id: json['id'] as String,
      code: json['code'] as String,
      stationId: json['stationId'] as String,
      stationName: json['stationName'] as String,
      destinationName: json['destinationName'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}
