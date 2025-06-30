import 'dart:core';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:metro_ticketing_system_mobile/features/cart/data/cart_repository.dart';
import 'package:metro_ticketing_system_mobile/features/cart/data/model/cart_info.dart';

@lazySingleton
class CartService {
  final CartRepository _repo;

  CartService(this._repo);

  Future<List<CartInfo>> getCartItems() async {
    return await _repo.getCartItems();
  }

  Future<bool> removeFromCart(String itemId) async {
    return await _repo.removeFromCart(itemId);
  }
  Future<bool> updateCart(String ticketId, int quantity) async {
    return await _repo.updateCart(ticketId, quantity);
  }
}