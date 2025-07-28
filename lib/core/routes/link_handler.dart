import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/cupertino.dart';

import '../../features/cart/data/cart_service.dart';
import '../../features/cart/data/model/momo_payment_query.dart';
import '../di/service_locator.dart';
import 'app_routes.dart';
import 'link_route.dart';

class DeepLinkService {
  static const List<DeepLinkRoute> _supportedRoutes = [
    DeepLinkRoute(
      scheme: 'metroticketsystem',
      host: 'payment',
      path: '/momo-return',
      routeName: AppRoutes.momoReturn,
    ),
  ];

  final AppLinks _appLinks;
  final GlobalKey<NavigatorState> _navigatorKey;
  StreamSubscription<Uri>? _linkSubscription;

  DeepLinkService({
    required GlobalKey<NavigatorState> navigatorKey,
    AppLinks? appLinks,
  }) : _navigatorKey = navigatorKey,
       _appLinks = appLinks ?? AppLinks();

  /// Initialize deep link handling
  Future<void> initialize() async {
    await _handleInitialLink();
    _listenToIncomingLinks();
  }

  Future<void> _handleInitialLink() async {
    try {
      final initialUri = await _appLinks.getInitialAppLink();
      if (initialUri != null) {
        _processDeepLink(initialUri);
      }
    } catch (e) {
      _handleError('Failed to get initial link: $e');
    }
  }

  /// Listen to incoming links while app is running
  void _listenToIncomingLinks() {
    _linkSubscription = _appLinks.uriLinkStream.listen(
      _processDeepLink,
      onError: (error) => _handleError('Deep link stream error: $error'),
    );
  }

  /// Process the deep link URI
  void _processDeepLink(Uri? uri) {
    if (uri == null) return;

    _logUriDetails(uri);

    final matchedRoute = _findMatchingRoute(uri);
    if (matchedRoute != null) {
      _navigateToRoute(matchedRoute.routeName, uri.queryParameters);
    } else {
      _handleUnknownRoute(uri);
    }
  }

  /// Find a matching route for the given URI
  DeepLinkRoute? _findMatchingRoute(Uri uri) {
    try {
      return _supportedRoutes.firstWhere((route) => route.matches(uri));
    } catch (e) {
      return null;
    }
  }

  /// Navigate to the specified route
  void _navigateToRoute(
    String routeName,
    Map<String, String> queryParameters,
  ) async {
    final navigator = _navigatorKey.currentState;
    if (navigator == null) return _handleError('Navigator not available');

    if (routeName == AppRoutes.momoReturn) {
      try {
        final query = PaymentQuery.fromQueryParameters(queryParameters);
        final result = await getIt<CartService>().confirmPayment(query);

        navigator.pushNamed(AppRoutes.momoReturn, arguments: result);
      } catch (e) {
        print("Deep link confirm payment error: $e");
        navigator.pushNamed('/error');
      }
    } else {
      navigator.pushNamed(routeName, arguments: queryParameters);
    }
  }

  /// Handle unknown/unsupported routes
  void _handleUnknownRoute(Uri uri) {
    print('Unknown deep link route: $uri');
  }

  /// Handle errors
  void _handleError(String error) {
    print('Deep Link Error: $error');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigatorKey.currentState?.pushNamed('/error');
    });
  }

  /// Log URI details for debugging
  void _logUriDetails(Uri uri) {
    debugPrint('Deep Link - Scheme: ${uri.scheme}');
    debugPrint('Deep Link - Host: ${uri.host}');
    debugPrint('Deep Link - Path: ${uri.path}');
    debugPrint('Deep Link - Query Parameters: ${uri.queryParameters}');
  }

  /// Dispose resources
  void dispose() {
    _linkSubscription?.cancel();
  }
}
