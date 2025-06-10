import 'package:flutter/material.dart';
import 'package:metro_ticketing_system_mobile/core/constants/app_color.dart';

class TicketTogglePanel extends StatefulWidget {
  const TicketTogglePanel({super.key});

  @override
  State<TicketTogglePanel> createState() => _TicketTogglePanelState();
}

class _TicketTogglePanelState extends State<TicketTogglePanel> {
  bool isInUseSelected = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: ConstantAppColor.primary,
            blurRadius: 5,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isInUseSelected = true;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isInUseSelected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    'Đang sử dụng',
                    style: TextStyle(
                      color: isInUseSelected ? ConstantAppColor.primary : Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // "Not used (2)" button
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isInUseSelected = false;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isInUseSelected
                      ? Colors.transparent
                      : ConstantAppColor.primary,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    'Chưa Sử dụng',
                    style: TextStyle(
                      color: isInUseSelected ? ConstantAppColor.primary : Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
