import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metro_ticketing_system_mobile/core/constants/app_color.dart';
import 'package:metro_ticketing_system_mobile/features/view_ticket/logic/view_ticket_cubit.dart';
import 'package:metro_ticketing_system_mobile/core/common/presentation/widgets/ticket_widgets/custom_ticket_app_bar.dart';
import 'package:metro_ticketing_system_mobile/features/view_ticket/presentation/widgets/view_ticket_body.dart';
import '../../../../core/di/service_locator.dart';
import '../../data/view_ticket_service.dart';
import 'expired_ticket_screen.dart';

const screenTitle = "Vé của tôi";

class ViewTicketScreen extends StatelessWidget {
  const ViewTicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ViewTicketCubit(getIt<ViewTicketService>())..getUsedTickets(),
      child: Scaffold(
        backgroundColor: ConstantAppColor.primary,
        body: Column(
          children: [
            CustomTicketAppBar(
              title: screenTitle,
              leftWidget: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ViewExpiredTicketScreen()),
                  );
                },
                child: Text(
                  "Hết hạn",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                ),
              ),
            ),

            ViewTicketBody(

            ),
          ],
        ),
      ),
    );
  }
}
