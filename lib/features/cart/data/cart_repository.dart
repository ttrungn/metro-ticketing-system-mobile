import 'dart:convert';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:metro_ticketing_system_mobile/core/configs/api_client.dart';
import 'package:metro_ticketing_system_mobile/features/cart/data/model/cart_info.dart';
// import 'package:metro_ticketing_system_mobile/features/cart/data/request/add_to_cart_request.dart';
// import 'package:metro_ticketing_system_mobile/features/cart/data/request/remove_from_cart_request.dart';
// import 'package:metro_ticketing_system_mobile/features/cart/data/response/cart_response.dart';

@lazySingleton
class CartRepository {
  CartRepository();

  Future<List<CartInfo>> getCartItems() async {
    try {
      var response = await ApiClient.dio.get("/order/Cart");
      final data = response.data;
      final List<dynamic> cartData = data['data'];
      return cartData.map((item) => CartInfo.fromJson(item as Map<String, dynamic>)).toList();
    } catch (e) {
      throw ("Get Cart Items error: $e");
    }
  }

  Future<bool> removeFromCart(String itemId) async {
    try {
      var response = await ApiClient.dio.delete("/order/Cart/$itemId");
      final data = response.data;
      return data['succeeded'] == true;
    } catch (e) {
      throw ("Remove from Cart error: $e");
    }
  }

  Future<bool> updateCart(String cartId, int quantity) async {
    try {
      var response = await ApiClient.dio.put("/order/Cart",
        data: {
          "id": cartId,
          "quantity": quantity,
        },
      );
      final data = response.data;
      return data['succeeded'] == true;
    } catch (e) {
      throw ("Add to Cart error: $e");
    }
  }


  Future<String> startPayment(double amount, List<CartInfo> cartItems) async{
    try{

      List<Map<String, dynamic>> orderDetails = cartItems.map((item) {
        var orderDetail = {
          "ticketId": item.ticketId,
          "boughtPrice": item.price,
          "entryStationId": null,
          "destinationStationId": null,
        };
        if (item.entryStationId != null && item.entryStationId!.isNotEmpty) {
          orderDetail["entryStationId"] = item.entryStationId!;
        }
        if (item.exitStationId != null && item.exitStationId!.isNotEmpty) {
          orderDetail["destinationStationId"] = item.exitStationId!;
        }

        return orderDetail;
      }).toList();

      var response = await ApiClient.dio.post(
        "/order/Payment/momo/create",
        data : {
          "amount" : amount,
          "orderDetails": orderDetails,
        }
      );
      print(response.data);

      return response.data["data"]["deeplink"];
    }catch(e){
      throw("Error: $e");
    }
  }
}



