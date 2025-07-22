import 'dart:convert';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:metro_ticketing_system_mobile/core/configs/api_client.dart';

@lazySingleton
class CartInfo {
  final String id;
  final String ticketId;
  final String ticketName;
  final String entryStationId;
  final String entryStationName;
  final String exitStationId;
  final String exitStationName;
  final String routeName;
  final int quantity;
  final double price;

  CartInfo({
    required this.id,
    required this.ticketId,
    required this.ticketName,
    required this.entryStationId,
    required this.entryStationName,
    required this.exitStationId,
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
      entryStationId: json['entryStationId']?.toString() ?? '',
      entryStationName: json['entryStationName']?.toString() ?? '',
      exitStationId: json['destinationStationId']?.toString() ?? '',
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
      ticketId: this.ticketId,
      ticketName: this.ticketName,
      price: this.price,
      quantity: quantity ?? this.quantity,
      routeName: this.routeName,
      entryStationId: this.entryStationId,
      entryStationName: this.entryStationName,
      exitStationId: this.exitStationId,
      exitStationName: this.exitStationName,
    );
  }

}