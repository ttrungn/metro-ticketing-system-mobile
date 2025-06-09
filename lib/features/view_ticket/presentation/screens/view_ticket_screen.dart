import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metro_ticketing_system_mobile/core/constants/app_color.dart';
import 'package:metro_ticketing_system_mobile/features/view_ticket/logic/view_ticket_cubit.dart';
import 'package:metro_ticketing_system_mobile/features/view_ticket/presentation/widgets/custom_ticket_app_bar.dart';
import 'package:metro_ticketing_system_mobile/features/view_ticket/presentation/widgets/view_ticket_body.dart';

const screenTitle = "Vé của tôi";

class ViewTicketScreen extends StatelessWidget {
  const ViewTicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstantAppColor.primary,
      body: Column(
        children: [
          CustomTicketAppBar(
            title: screenTitle,
            leftWidget: GestureDetector(
              onTap: () {},
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

          SizedBox(height: 20),
          ViewTicketBody(

          ),
        ],
      ),
    );
  }
}
