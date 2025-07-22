import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metro_ticketing_system_mobile/core/constants/app_color.dart';
import 'package:metro_ticketing_system_mobile/features/view_ticket/logic/view_ticket_cubit.dart';
import 'package:metro_ticketing_system_mobile/core/common/presentation/widgets/ticket_widgets/custom_ticket_app_bar.dart';
import '../widgets/view_expired_ticker_body.dart';
import '../../../../core/di/service_locator.dart';
import '../../data/view_ticket_service.dart';

const screenTitle = "Vé đã hết hạn";
class ViewExpiredTicketScreen extends StatelessWidget {
  const ViewExpiredTicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ViewTicketCubit(getIt<ViewTicketService>())..getExpiredTickets(),
      child: Scaffold(
        backgroundColor: ConstantAppColor.primary,
        body: Column(
          children: [
            CustomTicketAppBar(
              title: screenTitle,
              leadingIcon: Icons.arrow_back,
              onLeadingPressed: () {
                Navigator.pop(context);
              },
            ),
            ViewExpiredTicketBody(),
          ],
        ),
      ),
    );
  }
}

