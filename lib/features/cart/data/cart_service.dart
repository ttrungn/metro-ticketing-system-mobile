import 'dart:core';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:metro_ticketing_system_mobile/features/cart/data/cart_repository.dart';
import 'package:metro_ticketing_system_mobile/features/cart/data/model/cart_info.dart';
import 'package:url_launcher/url_launcher.dart';

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

  Future<bool> updateCart(String cartId, int quantity) async {
    return await _repo.updateCart(cartId, quantity);
  }

  Future<void> startPayment(double amount, List<CartInfo> cartItems) async {
    var momoDeeplink = await _repo.startPayment(amount, cartItems);
    await launchMoMoDeeplink(momoDeeplink);
  }

  Future<void> launchMoMoDeeplink(String deeplink) async {
    final Uri uri = Uri.parse(deeplink);
    print('Launching deeplink: $deeplink');

    // Check if the deeplink can be launched
    bool launched = await launchUrl(uri, mode: LaunchMode.externalApplication);

    if (launched) {
      print('MoMo app launched successfully');
    } else {}
  }
}
