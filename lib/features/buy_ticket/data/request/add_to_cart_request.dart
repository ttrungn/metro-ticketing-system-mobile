class AddToCartRequest {
  final String ticketId;
  final int quantity;
  final String? entryStationId;
  final String? destinationStationId;
  final String? routeId;

  AddToCartRequest({
    required this.ticketId,
    required this.quantity,
     this.entryStationId,
     this.destinationStationId,
     this.routeId,
  });

  Map<String, dynamic> toJson() {
    return {
      'ticketId': ticketId,
      'quantity': quantity,
      'entryStationId': entryStationId,
      'destinationStationId': destinationStationId,
      'routeId': routeId,
    };
  }

  factory AddToCartRequest.fromJson(Map<String, dynamic> json) {
    return AddToCartRequest(
      ticketId: json['ticketId'],
      quantity: json['quantity'],
      entryStationId: json['entryStationId'],
      destinationStationId: json['destinationStationId'],
      routeId: json['routeId'],
    );
  }
}
