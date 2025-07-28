import 'package:flutter/material.dart';
import 'package:metro_ticketing_system_mobile/main.dart';

class CartButton extends StatefulWidget {
  const CartButton({super.key});

  @override
  State<CartButton> createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: 80,
      child: Builder(
        builder: (context) {
          return FloatingActionButton(
            onPressed: () {
              navigatorKey.currentState?.pushNamed("/cart");
            },
            shape: CircleBorder(),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                  size: constraints.maxHeight * 0.6,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
