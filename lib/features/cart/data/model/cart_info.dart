import 'dart:convert';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:metro_ticketing_system_mobile/core/configs/api_client.dart';

@lazySingleton
class CartInfo {
  final String id;
  final String ticketName;
  final String entryStationName;
  final String exitStationName;
  final String routeName;
  final int quantity;
  final double price;

  CartInfo({
    required this.id,
    required this.ticketName,
    required this.entryStationName,
    required this.exitStationName,
    required this.routeName,
    required this.quantity,
    required this.price,
  });

  factory CartInfo.fromJson(Map<String, dynamic> json) {
    return CartInfo(
      id: json['cartId']?.toString() ?? '',
      ticketName: json['ticketName']?.toString() ?? '',
      entryStationName: json['entryStationName']?.toString() ?? '',
      exitStationName: json['destinationStationName']?.toString() ?? '',
      routeName: json['route']?.toString() ?? '',
      quantity: json['quantity'] ?? 0,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
    );
  }
  CartInfo copyWith({
    int? quantity,
  }) {
    return CartInfo(
      id: this.id,
      ticketName: this.ticketName,
      price: this.price,
      quantity: quantity ?? this.quantity,
      routeName: this.routeName,
      entryStationName: this.entryStationName,
      exitStationName: this.exitStationName,
    );
  }

}