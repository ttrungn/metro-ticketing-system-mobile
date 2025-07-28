import '../../../domain/entities/bus.dart';

class BusModel extends Bus {
  BusModel({
    required super.id,
    required super.code,
    required super.stationId,
    required super.stationName,
    required super.destinationName,
    required super.createdAt,
  });

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
