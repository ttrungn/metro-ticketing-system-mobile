

import 'package:flutter/material.dart';

class PhoneButton extends StatefulWidget {
  const PhoneButton({super.key});

  @override
  State<PhoneButton> createState() => _PhoneButtonState();
}

class _PhoneButtonState extends State<PhoneButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: 80,
      child: FloatingActionButton(
        onPressed: () {},
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
      ),
    );
  }
}
