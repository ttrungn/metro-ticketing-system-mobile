class SingleUseTicketRequest {
  final String routeId;
  final String entryStationId;
  final String exitStationId;

  const SingleUseTicketRequest({
    required this.routeId,
    required this.entryStationId,
    required this.exitStationId,
  });

  Map<String, dynamic> toJson() => {
    'routeId': routeId,
    'entryStationId': entryStationId,
    'exitStationId': exitStationId,
  };
}
