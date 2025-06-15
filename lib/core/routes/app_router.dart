import 'package:flutter/material.dart';
import 'package:metro_ticketing_system_mobile/features/auth/presentation/screens/login_screen.dart';
import 'package:metro_ticketing_system_mobile/features/buy_ticket/presentation/screens/buy_ticket_page.dart';
import 'package:metro_ticketing_system_mobile/features/feedback/presentation/screens/feedback_screen.dart';
import 'package:metro_ticketing_system_mobile/features/feedback/presentation/screens/new_feedback_screen.dart';
import 'package:metro_ticketing_system_mobile/features/view_ticket/presentation/screens/view_ticket_screen.dart';
import 'package:metro_ticketing_system_mobile/features/auth/presentation/screens/register_screen.dart';
import '../../features/student_verification/presentation/screens/verification_form_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/user/presentation/screens/profile_screen.dart';
import '../common/presentation/screens/error_screen.dart';
import 'app_routes.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
          settings: settings,
        );
      case AppRoutes.register:
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
          settings: settings,
        );
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
          settings: settings,
        );
      case AppRoutes.studentVerificationForm:
        return MaterialPageRoute(
          builder: (_) => const VerificationFormScreen(),
          settings: settings,
        );
      case AppRoutes.profile:
        return MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
          settings: settings,
        );
      case AppRoutes.myTicket:
        return MaterialPageRoute(
          builder: (_) => const ViewTicketScreen(),
          settings: settings,
        );
      case AppRoutes.buyTicket:
        return MaterialPageRoute(builder: (_) => const BuyTicketPage());
      case AppRoutes.feedback:
        return MaterialPageRoute(
          builder: (_) => const FeedbackScreen(),
          settings: settings,
        );
      case AppRoutes.newFeedback:
        return MaterialPageRoute(
          builder: (_) => const NewFeedbackScreen(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const ErrorScreen(),
          settings: settings,
        );
    }
  }
}
