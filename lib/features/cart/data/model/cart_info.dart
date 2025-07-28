import 'package:injectable/injectable.dart';

@lazySingleton
class CartInfo {
  final String id;
  final String ticketId;
  final String ticketName;
  final String? entryStationId;
  final String entryStationName;
  final String? exitStationId;
  final String exitStationName;
  final String routeName;
  final int quantity;
  final double price;

  CartInfo({
    required this.id,
    required this.ticketId,
    required this.ticketName,
    this.entryStationId,
    required this.entryStationName,
    this.exitStationId,
    required this.exitStationName,
    required this.routeName,
    required this.quantity,
    required this.price,
  });

  factory CartInfo.fromJson(Map<String, dynamic> json) {
    return CartInfo(
      id: json['cartId']?.toString() ?? '',
      ticketId: json['ticketId']?.toString() ?? '',
      ticketName: json['ticketName']?.toString() ?? '',
      entryStationId: json['entryStationId']?.toString(),
      entryStationName: json['entryStationName']?.toString() ?? '',
      exitStationId: json['destinationStationId']?.toString(),
      exitStationName: json['destinationStationName']?.toString() ?? '',
      routeName: json['route']?.toString() ?? '',
      quantity: json['quantity'] ?? 0,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
    );
  }
  CartInfo copyWith({int? quantity}) {
    return CartInfo(
      id: id,
      ticketId: ticketId,
      ticketName: ticketName,
      price: price,
      quantity: quantity ?? this.quantity,
      routeName: routeName,
      entryStationId: entryStationId,
      entryStationName: entryStationName,
      exitStationId: exitStationId,
      exitStationName: exitStationName,
    );
  }
}
