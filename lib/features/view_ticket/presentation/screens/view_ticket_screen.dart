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
      create:
          (_) => ViewTicketCubit(getIt<ViewTicketService>())..getUsedTickets(),
      child: Scaffold(
        backgroundColor:
            ConstantAppColor.primaryLight, // Changed to match body background
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [
                0.0,
                0.4,
                1.0,
              ], // Added stops for better gradient control
              colors: [
                ConstantAppColor.primary,
                ConstantAppColor.primary,
                ConstantAppColor.primaryLight,
              ],
            ),
          ),
          child: SafeArea(
            bottom: false, // Allow content to extend to bottom
            child: Column(
              children: [
                // App Bar with improved styling
                CustomTicketAppBar(
                  title: screenTitle,
                  leftWidget: _buildExpiredTicketButton(context),
                ),
                // Main content body
                const ViewTicketBody(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the expired ticket button with improved styling
  Widget _buildExpiredTicketButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: ConstantAppColor.primaryLight.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: GestureDetector(
        onTap: () => _navigateToExpiredTickets(context),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.history, color: ConstantAppColor.primaryLight, size: 16),
            const SizedBox(width: 4),
            Text(
              "Hết hạn",
              style: TextStyle(
                color: ConstantAppColor.primaryLight,
                fontWeight: FontWeight.w500,
                fontSize: 14,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Navigates to expired tickets screen
  void _navigateToExpiredTickets(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ViewExpiredTicketScreen()),
    );
  }
}
