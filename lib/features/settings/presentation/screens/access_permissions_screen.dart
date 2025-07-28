import 'package:flutter/material.dart';
import 'package:metro_ticketing_system_mobile/core/common/presentation/widgets/ticket_widgets/custom_ticket_app_bar.dart';
import 'package:metro_ticketing_system_mobile/features/settings/presentation/widgets/access_permissions_body.dart';

import '../../../../core/constants/app_color.dart';

const screenTitle = "Quyền Truy Cập";

class AccessPermissionsScreen extends StatelessWidget {
  const AccessPermissionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          AccessPermissionsBody(),
        ],
      ),
    );
  }
}
