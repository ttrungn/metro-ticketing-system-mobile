
import 'package:flutter/material.dart';
import 'package:metro_ticketing_system_mobile/features/auth/presentation/screens/login_screen.dart';

import '../../features/home/presentation/screens/home_screen.dart';
import '../common/presentation/screens/error_screen.dart';
import 'app_routes.dart';


class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login :
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
          settings: settings,
        );
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
          settings: settings,
        );
      default :
        return MaterialPageRoute(
          builder: (_) => const ErrorScreen(),
          settings: settings,
        );
    }
  }
}