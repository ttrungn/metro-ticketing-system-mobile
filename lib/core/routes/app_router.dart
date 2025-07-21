import 'package:flutter/material.dart';
import 'package:metro_ticketing_system_mobile/core/common/presentation/widgets/global_loading_overlay.dart';
import 'package:metro_ticketing_system_mobile/features/auth/presentation/screens/login_screen.dart';
import 'package:metro_ticketing_system_mobile/features/buy_ticket/presentation/screens/buy_ticket_page.dart';
import 'package:metro_ticketing_system_mobile/features/cart/presentation/screens/cart_page.dart';
import 'package:metro_ticketing_system_mobile/features/feedback/presentation/screens/feedback_screen.dart';
import 'package:metro_ticketing_system_mobile/features/feedback/presentation/screens/new_feedback_screen.dart';
import 'package:metro_ticketing_system_mobile/features/view_ticket/presentation/screens/view_ticket_screen.dart';
import 'package:metro_ticketing_system_mobile/features/auth/presentation/screens/register_screen.dart';
import '../../features/cart/presentation/screens/payment_result_screen.dart';
import '../../features/scan_qr_code/presentation/screens/scan_qr_code_exit_screen.dart';
import '../../features/student_verification/presentation/screens/verification_form_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/user/presentation/screens/profile_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../common/presentation/screens/error_screen.dart';
import '../../features/scan_qr_code/presentation/screens/scan_qr_code_screen.dart';
import 'app_routes.dart';

class AppRouter {
  static bool shouldShowCartButton(String? route) {
    const noCartRoutes = [
      AppRoutes.login,
      AppRoutes.cart,
      AppRoutes.profile,
      AppRoutes.feedback,
      AppRoutes.register,
      AppRoutes.newFeedback,
      AppRoutes.studentVerificationForm,
      AppRoutes.scannerToUsed,
      AppRoutes.scannerToExit,
    ];
    return !noCartRoutes.contains(route);
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
          settings: settings,
        );

      case AppRoutes.register:
        return MaterialPageRoute(
          builder: (_) => GlobalLoadingOverlay(
            showCartButton: shouldShowCartButton(settings.name),
            child: const RegisterScreen(),
          ),
          settings: settings,
        );

      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (_) => GlobalLoadingOverlay(
            showCartButton: shouldShowCartButton(settings.name),
            child: const HomeScreen(),
          ),
          settings: settings,
        );

      case AppRoutes.studentVerificationForm:
        return MaterialPageRoute(
          builder: (_) => GlobalLoadingOverlay(
            showCartButton: shouldShowCartButton(settings.name),
            child: const VerificationFormScreen(),
          ),
          settings: settings,
        );

      case AppRoutes.profile:
        return MaterialPageRoute(
          builder: (_) => const ProfileScreen(), // no cart overlay needed
          settings: settings,
        );

      case AppRoutes.myTicket:
        return MaterialPageRoute(
          builder: (_) => GlobalLoadingOverlay(
            showCartButton: shouldShowCartButton(settings.name),
            child: const ViewTicketScreen(),
          ),
          settings: settings,
        );

      case AppRoutes.buyTicket:
        return MaterialPageRoute(
          builder: (_) => GlobalLoadingOverlay(
            showCartButton: shouldShowCartButton(settings.name),
            child: const BuyTicketPage(),
          ),
          settings: settings,
        );

      case AppRoutes.feedback:
        return MaterialPageRoute(
          builder: (_) => GlobalLoadingOverlay(
            showCartButton: shouldShowCartButton(settings.name),
            child: const FeedbackScreen(),
          ),
          settings: settings,
        );

      case AppRoutes.newFeedback:
        return MaterialPageRoute(
          builder: (_) => GlobalLoadingOverlay(
            showCartButton: shouldShowCartButton(settings.name),
            child: const NewFeedbackScreen(),
          ),
          settings: settings,
        );

      case AppRoutes.settings:
        return MaterialPageRoute(
          builder: (_) => GlobalLoadingOverlay(
            showCartButton: shouldShowCartButton(settings.name),
            child: const SettingsScreen(),
          ),
          settings: settings,
        );

      case AppRoutes.cart:
        return MaterialPageRoute(
          builder: (_) => const CartPage(),
          settings: settings,
        );
      case AppRoutes.momoReturn:
        final args = settings.arguments as Map<String, dynamic>?;

        final orderId = args?['orderId'];
        final resultCode = args?['resultCode'];

        return MaterialPageRoute(
          builder: (_) => PaymentResultScreen(
            orderId: orderId,
            resultCode: resultCode,
          ),
          settings: settings,
        );
      case AppRoutes.scannerToUsed:
        return MaterialPageRoute(
          builder: (_) => GlobalLoadingOverlay(
            showCartButton: shouldShowCartButton(settings.name),
            child: const ScanQRCodeScreen(),
          ),
          settings: settings,
        );
      case AppRoutes.scannerToExit:
        return MaterialPageRoute(
          builder: (_) => GlobalLoadingOverlay(
            showCartButton: shouldShowCartButton(settings.name),
            child: const ScanQRCodeExitScreen(),
          ),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => GlobalLoadingOverlay(
            showCartButton: false,
            child: const ErrorScreen(),
          ),
          settings: settings,
        );
    }
  }}
