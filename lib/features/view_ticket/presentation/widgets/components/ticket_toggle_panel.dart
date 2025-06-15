import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metro_ticketing_system_mobile/core/constants/app_color.dart';
import 'package:metro_ticketing_system_mobile/features/view_ticket/logic/view_ticket_cubit.dart';

class TicketTogglePanel extends StatelessWidget {
  const TicketTogglePanel({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(width: 1, color: Colors.black12),
      ),
      child: BlocBuilder<ViewTicketCubit,ViewTicketState>(builder: (context, state) {
        bool isInUseSelected = false;
        if (state is ViewTicketUnused){
          isInUseSelected = false;
        } else if (state is ViewTicketInUse){
          isInUseSelected = true;
        }
        return Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: (){
                  if (state is ViewTicketUnused){
                    context.read<ViewTicketCubit>().toggleUsedBtn();
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: isInUseSelected ? ConstantAppColor.primary : Colors.transparent,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      'Đang sử dụng',
                      style: TextStyle(
                        color: isInUseSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: (){
                  if(state is ViewTicketInUse){
                    context.read<ViewTicketCubit>().toggleUnusedBtn();
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: isInUseSelected ? Colors.transparent : ConstantAppColor.primary,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      'Chưa Sử dụng',
                      style: TextStyle(
                        color:  isInUseSelected ? Colors.black : Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }, ),
    );
  }
}



