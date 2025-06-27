


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metro_ticketing_system_mobile/core/constants/app_color.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thông tin đơn hàng", style: TextStyle(color: Colors.white),),
            backgroundColor: ConstantAppColor.primary,

      ),
      body: Container(),
    );
  }
}
