import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metro_ticketing_system_mobile/core/common/cubit/loading_cubit.dart';
import 'package:metro_ticketing_system_mobile/core/constants/app_color.dart';
import 'package:metro_ticketing_system_mobile/core/routes/app_router.dart';
import 'package:metro_ticketing_system_mobile/core/routes/app_routes.dart';
import 'package:metro_ticketing_system_mobile/core/routes/link_handler.dart';
import 'package:metro_ticketing_system_mobile/features/cart/logic/payment_cubit.dart';

import 'core/di/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (_) => LoadingCubit()),
        BlocProvider(create: (_) => PaymentResultCubit()),
      ],
      child: const MyApp(),
    ),
  );
}
final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final DeepLinkService _deepLinkService =   DeepLinkService(navigatorKey: navigatorKey);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _deepLinkService.initialize();
  }

  @override
  void dispose() {
    _deepLinkService.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Metro Ticketing System',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: ThemeData(
        scaffoldBackgroundColor: ConstantAppColor.primaryLight,
        colorScheme: ColorScheme.light(
          primary: ConstantAppColor.primary,
          surface: ConstantAppColor.primaryLight,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),

      initialRoute: AppRoutes.login,
      onGenerateRoute: AppRouter.onGenerateRoute,



    );
  }
}