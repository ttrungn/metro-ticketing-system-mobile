import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:metro_ticketing_system_mobile/features/view_ticket/data/models/response/ticket_box_info_list_response.dart';
import 'package:metro_ticketing_system_mobile/features/view_ticket/presentation/widgets/components/ticket_toggle_panel.dart';

import '../../../../core/constants/app_color.dart';
import '../../logic/view_ticket_cubit.dart';
import 'components/ticket_box.dart';

class ViewTicketBody extends StatelessWidget {
  const ViewTicketBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: ConstantAppColor.primaryLight,
          borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        ),
        child: Column(
          children: [
            TicketTogglePanel(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: BlocBuilder<ViewTicketCubit, ViewTicketState>(
                  builder: (context, state) {
                    var tickets = [];
                    if (state is ViewTicketInUse) {
                      tickets = state.usedTickets as List<TicketBoxInfo>;
                    }
                    if (state is ViewTicketUnused) {
                      tickets = state.unusedTickets as List<TicketBoxInfo>;
                    }

                    return ListView.builder(
                      padding: EdgeInsets.only(bottom: 25),
                      itemCount: tickets.length,
                      itemBuilder: (context, index) {
                        final name = tickets[index].name;
                        final DateTime? activateDate = tickets[index].activateDate;

                        // --- Alternative way to format the date manually ---
                        final String formattedActivateDate = activateDate != null
                            ? '${activateDate.hour.toString().padLeft(2, '0')}:'
                            '${activateDate.minute.toString().padLeft(2, '0')} '
                            '${activateDate.day.toString().padLeft(2, '0')}/'
                            '${activateDate.month.toString().padLeft(2, '0')}/'
                            '${activateDate.year}'
                            : 'N/A'; // Or h
                        return TicketBox(
                          ticketName: name,
                          activateDate: formattedActivateDate,
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
