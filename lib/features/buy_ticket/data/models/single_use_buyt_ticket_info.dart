class SingleUseTicketInfo {
  final String id;
  final String name;
  final double price;
  final int expireInDay;
  final String entryStation;
  final String exitStation;

  SingleUseTicketInfo({
    required this.id,
    required this.name,
    required this.price,
    required this.expireInDay,
    required this.entryStation,
    required this.exitStation,
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
      expireInDay: (data['expirationInDay'] as int?) ?? 0,
      entryStation: data['entryStation']?.toString() ?? 'Unknown',
      exitStation: data['exitStation']?.toString() ?? 'Unknown',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'price': price,
    'expirationInDay': expireInDay,
    'entryStation': entryStation,
    'exitStation': exitStation,
  };
}
