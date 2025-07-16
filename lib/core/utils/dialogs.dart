// lib/core/utils/dialogs.dart
import 'package:flutter/material.dart';

Future<void> showCustomDialog(
  BuildContext context,
  IconData icon,
  Color iconColor,
  String title,
  String content,
  List<Widget> actionButtons,
) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (ctx) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(icon, color: iconColor, size: 28),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: Text(content, style: TextStyle(fontSize: 16)),
        actions: actionButtons,
      );
    },
  );
}
