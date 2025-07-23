class Bus {
  final String id;
  final String code;
  final String stationId;
  final String stationName;
  final String destinationName;
  final DateTime createdAt;

  Bus({
    required this.id,
    required this.code,
    required this.stationId,
    required this.stationName,
    required this.destinationName,
    required this.createdAt,
  });
}
