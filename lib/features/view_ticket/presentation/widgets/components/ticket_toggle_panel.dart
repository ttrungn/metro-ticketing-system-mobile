import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metro_ticketing_system_mobile/core/constants/app_color.dart';
import 'package:metro_ticketing_system_mobile/features/view_ticket/logic/view_ticket_cubit.dart';

class TicketTogglePanel extends StatelessWidget {
  const TicketTogglePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          width: 1.5,
          color: ConstantAppColor.primary.withOpacity(0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            offset: const Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      child: BlocBuilder<ViewTicketCubit, ViewTicketState>(
        builder: (context, state) {
          final isInUseSelected =
              context.read<ViewTicketCubit>().isInUseSelected;

          return Row(
            children: [
              // Đang sử dụng
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (!isInUseSelected) {
                      context.read<ViewTicketCubit>().toggleUsedBtn();
                    }
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color:
                          isInUseSelected
                              ? ConstantAppColor.primary
                              : Colors.transparent,
                      borderRadius: BorderRadius.circular(21),
                      boxShadow:
                          isInUseSelected
                              ? [
                                BoxShadow(
                                  color: ConstantAppColor.primary.withOpacity(
                                    0.3,
                                  ),
                                  offset: const Offset(0, 2),
                                  blurRadius: 6,
                                ),
                              ]
                              : null,
                    ),
                    child: Center(
                      child: Text(
                        'Đang sử dụng',
                        style: TextStyle(
                          color:
                              isInUseSelected
                                  ? Colors.white
                                  : ConstantAppColor.textSecondary,
                          fontWeight:
                              isInUseSelected
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                          fontSize: 15,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Chưa sử dụng
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (isInUseSelected) {
                      context.read<ViewTicketCubit>().toggleUnusedBtn();
                    }
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color:
                          !isInUseSelected
                              ? ConstantAppColor.primary
                              : Colors.transparent,
                      borderRadius: BorderRadius.circular(21),
                      boxShadow:
                          !isInUseSelected
                              ? [
                                BoxShadow(
                                  color: ConstantAppColor.primary.withOpacity(
                                    0.3,
                                  ),
                                  offset: const Offset(0, 2),
                                  blurRadius: 6,
                                ),
                              ]
                              : null,
                    ),
                    child: Center(
                      child: Text(
                        'Chưa sử dụng',
                        style: TextStyle(
                          color:
                              !isInUseSelected
                                  ? Colors.white
                                  : ConstantAppColor.textSecondary,
                          fontWeight:
                              !isInUseSelected
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                          fontSize: 15,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
