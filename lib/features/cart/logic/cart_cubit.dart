import 'dart:core';

import 'package:debounce_throttle/debounce_throttle.dart';
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
  final Map<String, Debouncer<int>> _quantityDebouncers = {};

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
    updateQuantity(item, item.quantity + 1);
  }

  void decreaseQuantity(CartInfo item) {
      if(item.quantity > 1)
        updateQuantity(item, item.quantity - 1);
  }

  void updateQuantity(CartInfo item, int newQuantity) {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;

      final updatedItems = currentState.items.map((e) {
        if (e.id == item.id) {
          return e.copyWith(quantity: newQuantity);
        }
        return e;
      }).toList();

      final newTotal = updatedItems.fold<double>(
        0, (sum, item) => sum + item.price * item.quantity,
      );

      emit(CartLoaded(items: updatedItems, totalPrice: newTotal));

      if (!_quantityDebouncers.containsKey(item.id)) {
        final debouncer = Debouncer<int>(
          Duration(milliseconds: 900),
          initialValue: item.quantity,
        );
        debouncer.values.listen((qty) async {
          try {
            await cartService.updateCart(item.id, qty);
          } catch (e) {
            emit(CartError(message: 'Lỗi khi cập nhật số lượng: $e'));
          }
        });
        _quantityDebouncers[item.id] = debouncer;
      }

      _quantityDebouncers[item.id]!.value = newQuantity;
    }
  }


  @override
  Future<void> close() async {
    _quantityDebouncers.clear();
    await super.close();
  }

}
