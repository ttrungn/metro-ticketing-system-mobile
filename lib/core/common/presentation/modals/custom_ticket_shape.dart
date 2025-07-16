import 'package:flutter/material.dart';

class CustomTicketShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(25),
      ),
    );
    path.addOval(
      Rect.fromCircle(center: Offset(0, size.height * 0.85), radius: 15),
    );
    path.addOval(
      Rect.fromCircle(
        center: Offset(size.width, size.height * 0.85),
        radius: 15,
      ),
    );
    path.fillType = PathFillType.evenOdd;
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
