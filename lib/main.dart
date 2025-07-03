import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metro_ticketing_system_mobile/core/common/cubit/loading_cubit.dart';
import 'package:metro_ticketing_system_mobile/core/constants/app_color.dart';
import 'package:metro_ticketing_system_mobile/core/routes/app_router.dart';
import 'package:metro_ticketing_system_mobile/core/routes/app_routes.dart';

import 'core/common/presentation/widgets/global_loading_overlay.dart';
import 'core/di/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (_) => LoadingCubit())],
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
  StreamSubscription<Uri>? _sub;
  final AppLinks _appLinks = AppLinks();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _handleIncomingLinks();
  }

  void _handleIncomingLinks() async  {
    print("LINKKKKKKKKKKKKKKKKKKK");
    _sub = _appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        print("Scheme: ${uri.scheme}");
        print("Host: ${uri.host}");
        print("Path: ${uri.path}");

        // Fixed: Remove the extra "ing" from the scheme
        if (uri.scheme == 'metroticketsystem' &&  // Changed from 'metroticketingsystem'
            uri.host == 'payment' &&
            uri.path == '/momo-return') {
          print("URI matches criteria - navigating to payment result");
          WidgetsBinding.instance.addPostFrameCallback((_) {
            navigatorKey.currentState?.pushNamed(AppRoutes.momoReturn, arguments: uri.queryParameters);
          });
        } else {
          print("URI doesn't match criteria");
        }
      }
    },onError: (err){
      print('Error :$err');
      navigatorKey.currentState?.pushNamed( "/error");
    });

    final initialUri = await _appLinks.getInitialAppLink();
    if (initialUri != null &&
        initialUri.scheme == 'metroticketsystem' &&
        initialUri.host == 'payment' &&
        initialUri.path == '/momo-return') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        navigatorKey.currentState?.pushNamed(AppRoutes.momoReturn,
            arguments: initialUri.queryParameters);
      });
    }
  }
  @override
  void dispose() {
    _sub?.cancel();
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