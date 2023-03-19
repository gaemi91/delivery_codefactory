import 'package:delivery_codefactory/common/route/route_common_splash.dart';
import 'package:delivery_codefactory/common/route/route_common_tap.dart';
import 'package:delivery_codefactory/restaurant/route/route_restaurant_basket.dart';
import 'package:delivery_codefactory/restaurant/route/route_restaurant_detail.dart';
import 'package:delivery_codefactory/user/model/model_user.dart';
import 'package:delivery_codefactory/user/provider/provider_user_me.dart';
import 'package:delivery_codefactory/user/route/route_user_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final changeNotifierProviderAuth = ChangeNotifierProvider<ChangeNotifierAuth>((ref) {
  return ChangeNotifierAuth(ref: ref);
});

class ChangeNotifierAuth extends ChangeNotifier {
  final Ref ref;

  ChangeNotifierAuth({required this.ref}) {
    ref.listen<ModelUserBase?>(stateNotifierProviderUserMe, (previous, next) {
      if (previous != next) {
        notifyListeners();
      }
    });
  }

  List<GoRoute> routes = [
    GoRoute(
      path: '/splash',
      name: RouteCommonSplash.routeName,
      builder: (context, state) => const RouteCommonSplash(),
    ),
    GoRoute(
      path: '/login',
      name: RouteUserLogin.routeName,
      builder: (context, state) => const RouteUserLogin(),
    ),
    GoRoute(
      path: '/basket',
      name: RouteRestaurantBasket.routeName,
      builder: (context, state) => const RouteRestaurantBasket(),
    ),
    GoRoute(
      path: '/',
      name: RouteCommonTap.routeName,
      builder: (context, state) => const RouteCommonTap(),
      routes: [
        GoRoute(
          path: 'restaurant/:rid',
          name: RouteRestaurantDetail.routeName,
          builder: (context, state) => RouteRestaurantDetail(id: state.params['rid']!),
        )
      ],
    ),
  ];

  void logOut() {
    ref.read(stateNotifierProviderUserMe.notifier).logOut();
  }

  String? redirectRoute(GoRouterState state) {
    final ModelUserBase? stateUser = ref.read(stateNotifierProviderUserMe);
    final loggingIn = state.location == '/login';

    if (stateUser == null) {
      return loggingIn ? null : '/login';
    }

    if (stateUser is ModelUser) {
      return loggingIn || state.location == '/splash' ? '/' : null;
    }

    if (stateUser is ModelUserError) {
      return !loggingIn ? '/login' : null;
    }

    return null;
  }
}
