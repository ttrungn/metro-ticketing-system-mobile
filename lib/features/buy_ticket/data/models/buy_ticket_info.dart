class BuyTicketInfo {
  final String id;
  final String name;
  final double price;
  final int expireInDay;
  final int activeInDay;
  final TicketType type;

  BuyTicketInfo({
    required this.id,
    required this.name,
    required this.price,
    required this.expireInDay,
    required this.activeInDay,
    required this.type,
  });

  factory BuyTicketInfo.fromJson(Map<String, dynamic> data) {
    print(data);
    double parsedPrice;
    try {
      parsedPrice = double.parse(data['price']);
    } catch (e) {
      parsedPrice = 0.0;
    }
    print(data['id']);
    return BuyTicketInfo(
      id: data['id']?.toString() ?? '',
      name: data['name']?.toString() ?? '',
      price: (data['price'] as num?)?.toDouble() ?? 0.0,
      expireInDay: (data['expirationInDay'] as int?) ?? 0,
      activeInDay: (data['activeInDay'] as int?) ?? 0,
      type: _parseTicketType(data['ticketType']),
    );
  }
  static TicketType _parseTicketType(dynamic value) {
    switch (value) {
      case 1:
        return TicketType.singleUse;
      case 2:
        return TicketType.multipleUse;
      case 3:
        return TicketType.student;
      default:
        return TicketType.singleUse; // fallback
    }
  }
}

enum TicketType { singleUse, multipleUse, student }
