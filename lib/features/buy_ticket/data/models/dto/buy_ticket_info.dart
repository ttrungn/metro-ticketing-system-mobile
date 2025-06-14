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
    double parsedPrice;
    try {
      parsedPrice = double.parse(data['price']);
    } catch (e) {
      parsedPrice = 0.0;
    }
    return BuyTicketInfo(
      id: data['id'],
      name: data['name'],
      price: parsedPrice,
      expireInDay: int.parse(data["expire-in-day"]),
      activeInDay: int.parse(data["active-in-day"]),
      type: data["type"],
    );
  }
}

enum TicketType { singleUse, multipleUse, student }
