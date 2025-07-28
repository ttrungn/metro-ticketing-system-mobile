import 'package:flutter/material.dart';
import 'package:metro_ticketing_system_mobile/core/common/presentation/widgets/ticket_widgets/custom_ticket_app_bar.dart';
import 'package:metro_ticketing_system_mobile/features/settings/presentation/widgets/settings_body.dart';

import '../../../../core/constants/app_color.dart';

const screenTitle = "Cài Đặt";

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstantAppColor.primary,
      body: Column(
        children: [CustomTicketAppBar(title: screenTitle), SettingsBody()],
      ),
    );
  }
}
