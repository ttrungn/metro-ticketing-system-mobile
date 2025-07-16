class SingleUseTicketInfo {
  final String id;
  final String name;
  final double price;
  final int expireInDays;
  final String entryStationId;
  final String exitStationId;
   String entryStationName;
   String exitStationName;

  SingleUseTicketInfo({
    required this.id,
    required this.name,
    required this.price,
    required this.entryStationId,
    required this.exitStationId,
    required this.expireInDays,
    required this.entryStationName,
    required this.exitStationName,
  });

  factory SingleUseTicketInfo.fromJson(Map<String, dynamic> data) {
    double parsedPrice;
    try {
      parsedPrice = double.parse(data['price'].toString());
    } catch (e) {
      parsedPrice = 0.0;
    }

    return SingleUseTicketInfo(
      id: data['id']?.toString() ?? '',
      name: data['name']?.toString() ?? '',
      price: parsedPrice,
      expireInDays: (data['expireInDays'] as int?) ?? 0,
      exitStationId: data['exitStationId'],
      entryStationId: data['entryStationId'],
      entryStationName: data['entryStationName']?.toString() ?? 'Unknown',
      exitStationName: data['exitStationName']?.toString() ?? 'Unknown',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'price': price,
    'exitStationId' : exitStationId,
    'entryStationId' : entryStationId,
    'expirationInDay': expireInDays,

  };
}
