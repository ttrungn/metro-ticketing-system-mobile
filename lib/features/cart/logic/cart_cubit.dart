import 'dart:core';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metro_ticketing_system_mobile/features/cart/data/cart_repository.dart';
import 'package:metro_ticketing_system_mobile/features/cart/data/model/cart_info.dart';
import 'package:metro_ticketing_system_mobile/features/cart/data/cart_service.dart';



abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartInfo> items;
  final double totalPrice;

  CartLoaded({required this.items, required this.totalPrice});
}

class CartError extends CartState {
  final String message;

  CartError({required this.message});
}
class CartCubit extends Cubit<CartState> {
  final CartService cartService;

  CartCubit()
      : cartService = CartService(CartRepository()),
        super(CartInitial());

  Future<void> loadCart() async {
    emit(CartLoading());
    try {
      final items = await cartService.getCartItems();
      final total = items.fold<double>(0, (sum, item) => sum + item.price * item.quantity);
      emit(CartLoaded(items: items, totalPrice: total));
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }

  Future<void> removeItem(String itemId) async {
    try {
      await cartService.removeFromCart(itemId);
      await loadCart(); // reload after deletion
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }
  void increaseQuantity(CartInfo item) {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      final updatedItems = currentState.items.map((e) {
        if (e.id == item.id) {
          return e.copyWith(quantity: e.quantity + 1);
        }
        return e;
      }).toList();

      final newTotal = updatedItems.fold<double>(0, (sum, item) => sum + item.price * item.quantity);
      emit(CartLoaded(items: updatedItems, totalPrice: newTotal));
    }
  }

  void decreaseQuantity(CartInfo item) {
    if (state is CartLoaded && item.quantity > 1) {
      final currentState = state as CartLoaded;
      final updatedItems = currentState.items.map((e) {
        if (e.id == item.id && e.quantity > 1) {
          return e.copyWith(quantity: e.quantity - 1);
        }
        return e;
      }).toList();

      final newTotal = updatedItems.fold<double>(0, (sum, item) => sum + item.price * item.quantity);
      emit(CartLoaded(items: updatedItems, totalPrice: newTotal));
    }
  }
  void updateQuantity(CartInfo item, int newQty) {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      final updatedItems = currentState.items.map((e) {
        if (e.id == item.id) {
          return e.copyWith(quantity: newQty);
        }
        return e;
      }).toList();

      final newTotal = updatedItems.fold<double>(0, (sum, item) => sum + item.price * item.quantity);
      emit(CartLoaded(items: updatedItems, totalPrice: newTotal));
    }
  }

}
